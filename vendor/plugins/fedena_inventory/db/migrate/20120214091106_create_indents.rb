class CreateIndents < ActiveRecord::Migration
  def self.up
    create_table :indents do |t|
      t.integer :user_id
      t.integer :store_id
      t.string :indent_no
      t.date :expected_date
      t.string :status
      t.integer :employee_department_id
      t.integer :manager_id
      t.text :description

      t.timestamps
    end
    
  end

  def self.down
    drop_table :indents
  end
end
