class AddResponseToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :response, :boolean
  end
end
