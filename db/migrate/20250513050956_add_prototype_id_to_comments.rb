class AddPrototypeIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :prototype, null: false, foreign_key: true
  end
end
