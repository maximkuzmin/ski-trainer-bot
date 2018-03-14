# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  telegram_id      :string
#  sex              :string
#  age              :integer
#  training_plan_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'active_record'

class User < ActiveRecord::Base
  belongs_to :training_plan
  has_many :training_participations

  def is_filled?
    sex && age && training_plan
  end
end
