class CreateAdvertisements < ActiveRecord::Migration[5.1]
  def change
    create_table :advertisements do |t|
      t.string :title
      t.integer :price
      t.text :content
      t.integer :advertiser_id
      t.boolean :published

      t.timestamps
    end
  end
end
