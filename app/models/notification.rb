class Notification < ActiveRecord::Base
  attr_accessible :notify, :reminder_date, :task_id
  validates :task_id, uniqueness: true
  belongs_to :task
end
