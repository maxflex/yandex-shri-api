class CreateAuditoria < ActiveRecord::Migration[5.0]
  def change
    create_table :auditoria do |t|
      t.string :name
      t.integer :capacity
      t.string :address
      t.timestamps
    end
  end
end
