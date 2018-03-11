require 'active_record'

class TrainingPlan < ActiveRecord::Base
  has_many :users
  has_many :trainings
end
