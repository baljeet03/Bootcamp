class Task < ActiveRecord::Base
  include TasksHelper
  attr_accessible :deadline, :description, :priority, :title

  validates_length_of :title, :allow_blank => false, in: 5..50
  validates :priority, presence: true
  validates_length_of :description, :maximum => 500, :allow_blank => false
  validate :deadline_should_be_greater_than_current_Date?

  def deadline_should_be_greater_than_current_Date?
    self.errors.add("Deadline date", " should be in future") if deadline.present? && deadline < Date.today
  end

end
