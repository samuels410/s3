class AddWorkflowStateToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :workflow_state, :string,default: "active"
  end
end
