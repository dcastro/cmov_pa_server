class Workday < ActiveRecord::Base
  belongs_to :schedule_plan
  validate :troll
  
  def troll
    #errors.add(:start, "trolololol")
  end
end
