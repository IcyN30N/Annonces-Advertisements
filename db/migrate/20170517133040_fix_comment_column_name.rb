class FixCommentColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :commenter_id, :user_id
  end
end
