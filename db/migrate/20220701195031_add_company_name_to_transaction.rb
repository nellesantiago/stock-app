class AddCompanyNameToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :company_name, :string
  end
end
