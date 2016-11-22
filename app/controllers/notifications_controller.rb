class NotificationsController < ApplicationController

  # show all the reminders
  def show
    @reminders = Task.joins(:notification).where('notifications.notify = true')
    @reminders = @reminders.paginate(:page => params[:page], :per_page => 10)
  end

  #delete the particular notification
  def delete
    @reminder = Notification.find_by_task_id(params[:id])
    if @reminder.delete
      gflash :success => "Reminder for the Task Id "+ params[:id].to_s + " is off"
      redirect_to reminders_path
    else
      gflash :errors => "Something went wrong during deletion of reminder"
      redirect_to root_path
    end
  end

  #delete all the notification
  def deleteAll
    if Notification.delete_all
      gflash :success => "Reminder for All the task has been removed"
      redirect_to reminders_path
    else
      gflash :errors => "Something went wrong during deletion of reminders"
      redirect_to root_path
    end
  end
  # deletion of reminder in background

end