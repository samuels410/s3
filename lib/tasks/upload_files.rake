namespace :photos do

  desc 'Rake task to upload files'
  task :upload => :environment do

    photo_dir = '/Users/samuelsanthosh/Documents/outboud-images'
    count = 0
    user = User.first
    Dir.glob(File.join(photo_dir,'*')).each do |photo_path|
      if File.basename(photo_path)[0]!= '.' and !File.directory? photo_path
        puts File.basename(photo_path, '.*')
        image_file_name =  File.basename(photo_path, '.*')

        photo = Photo.where(image_file_name: image_file_name).first
        puts "photo:#{photo}"
        unless photo
          count +=1
          photo = Photo.new
          File.open(photo_path) do |f|
            photo.image = f
            photo.user_id = user.id
            photo.save!
          end #file gets closed automatically here
        end
      end
    end

    puts count

  end
end