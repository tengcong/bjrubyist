class AddAttributesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :from, :string
    add_column :events, :to, :string
  end
end
