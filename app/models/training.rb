require 'active_record'

class Training < ActiveRecord::Base
  belongs_to :training_plan
end