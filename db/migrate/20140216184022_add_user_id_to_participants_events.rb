class AddUserIdToParticipantsEvents < ActiveRecord::Migration
  def change
    remove_column :events_users, :user_id, :integer
    add_column :events_users, :participant_id, :integer
  end
end
