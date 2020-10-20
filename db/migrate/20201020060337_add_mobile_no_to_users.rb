class AddMobileNoToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mobile_no, :string
  end
end
