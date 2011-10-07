class Workday < ActiveRecord::Base
  belongs_to :schedule_plan
end
