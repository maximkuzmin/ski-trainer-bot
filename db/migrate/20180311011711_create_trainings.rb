class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings do |t|
      t.string :title
      t.string :description
      t.references :training_plan, foreign_key: true

      t.timestamps
    end
  end
end
