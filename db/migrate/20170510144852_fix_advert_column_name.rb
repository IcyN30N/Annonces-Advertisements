class FixAdvertColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :advertisements, :advertiser_id, :user_id
  end
end
