class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.string :name
      t.float :value
      t.integer :account_type
      t.references :owner, index: true

      t.timestamps
    end
  end
end
