class AddImageDataToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :image_data, :text
  end
end
