class RemoveResponseFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :response, :boolean
  end
end
