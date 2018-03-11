class CreateTrainingPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :training_plans do |t|
      t.string     :title

      t.timestamps null: false
    end
  end
end
