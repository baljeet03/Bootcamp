class Task < ActiveRecord::Base
  include TasksHelper
  attr_accessible :deadline, :reminderDate, :description, :priority, :title

  validates_length_of :title, :allow_blank => false, in: 5..50
  validates :priority, presence: true
  validates_length_of :description, :maximum => 500, :allow_blank => false

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |task|
        csv << task.attributes.values_at(*column_names)
      end
    end
  end
end
