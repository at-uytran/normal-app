class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.integer :category_id
      t.integer :process_status, default: 0
      t.string :name
      t.string :description
      t.string :file

      t.timestamps
    end
  end
end
