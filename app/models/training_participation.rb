require 'active_record'

class TrainingParticipation < ActiveRecord::Base
  belongs_to :training
  belongs_to :user
  has_one :training_plan, through: :training
end
