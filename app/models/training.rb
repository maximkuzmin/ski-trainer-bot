# == Schema Information
#
# Table name: trainings
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :string
#  training_plan_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'active_record'

class Training < ActiveRecord::Base
  belongs_to :training_plan
  has_many :training_participations
end
