class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|

      t.text :content
      t.references :user, index: true
      t.references :meet_up, index: true
      t.timestamps
    end
  end
end
