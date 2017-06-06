class AddAvertIdColumnToComments < ActiveRecord::Migration[5.1]
  def change
    change_table :comments do |t|
      t.integer :advertisement_id
    end
  end
end
