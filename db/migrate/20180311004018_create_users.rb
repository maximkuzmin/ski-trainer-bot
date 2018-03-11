class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string     :phone_number
      t.string     :sex
      t.integer    :age
      t.references :training_plan, foreign_key: true

      t.timestamps
    end
  end
end
