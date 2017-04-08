class PhotosController < ApplicationController
  require 'zip'
  before_action :authenticate_user!
  @@per_page = 52

  def upload_photos
    params['Photo'][:photos].each do |photo|
      photo = Photo.create(image: photo,user_id: current_user.id)
    end
    flash[:notice] = "The photos uploaded successfully"
    redirect_to photos_path
  end

  def index
    @photos = Photo.active.order('created_at DESC' ).paginate( :page => params[:page] || 1, :per_page => @@per_page )
    @photo = Photo.name
  end

  def download
    photo = Photo.where(id: params[:id]).first
    send_file photo.image.path, :type => photo.image_content_type, :disposition => 'attachment'
  end

  def download_zip
    if params[:query_params].present?
      page_no = params[:query_params][:page].to_i
    else
      page_no = 1
    end

      @photos = Photo.active.paginate( :page => page_no, :per_page => @@per_page )

      #Attachment name
      filename = "photos-#{page_no}.zip"
      temp_file = Tempfile.new(filename)

      begin
        #This is the tricky part
        #Initialize the temp file as a zip file
        Zip::OutputStream.open(temp_file) { |zos| }

        #Add files to the zip file as usual
        Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
          @photos.each do |photo|
            zip.add(photo.image_file_name, photo.image.path)
          end

        end

        #Read the binary data from the file
        zip_data = File.read(temp_file.path)

        #Send the data to the browser as an attachment
        #We do not send the file directly because it will
        #get deleted before rails actually starts sending it
        send_data(zip_data, :type => 'application/zip', :filename => filename)
      ensure
        #Close and delete the temp file
        temp_file.close
        temp_file.unlink
      end
  end

  def destroy
    photo = Photo.where(id: params[:id]).first
    photo.update_attributes(workflow_state: "deleted")
    flash[:notice] = "The photo deleted successfully"
    redirect_to photos_path
  end

end
