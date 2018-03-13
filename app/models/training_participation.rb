# == Schema Information
#
# Table name: training_participations
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  training_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'active_record'

class TrainingParticipation < ActiveRecord::Base
  belongs_to :training
  belongs_to :user
  has_one :training_plan, through: :training
end
