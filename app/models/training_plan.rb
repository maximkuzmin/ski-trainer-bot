# == Schema Information
#
# Table name: training_plans
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'active_record'

class TrainingPlan < ActiveRecord::Base
  has_many :users
  has_many :trainings
end
