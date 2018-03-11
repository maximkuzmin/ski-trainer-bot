require 'active_record'

class User < ActiveRecord::Base
  belongs_to :training_plan
end
