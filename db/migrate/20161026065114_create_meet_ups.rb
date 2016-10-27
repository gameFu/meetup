class CreateMeetUps < ActiveRecord::Migration[5.0]
  def change
    create_table :meet_ups do |t|

      t.text :content
      t.references :user, index: true
      t.timestamps
    end
    add_index :meet_ups, [:user_id, :created_at]
  end
end
