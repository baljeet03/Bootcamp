require 'mail'
class TasksController < ApplicationController

  include TasksHelper
  # GET /tasks
  # GET /tasks.json
  def index
    @input = {}
    gflash :notice => "The product has been created successfully!"
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find_by_id(params[:id])
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    #
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find_by_id(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.status="active"
    if @task.save
      flash[:success] = "Your new task has been created"
      redirect_to root_path
    else
      render "tasks/new"
    end
  end


  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find_by_id(params[:id])
    @task.status="active"
    if @task.update_attributes(params[:task])
      redirect_to show_path
    else
      render 'tasks/edit'
    end
  end

  # For open and close tasks
  # GET /tasks/filter/active
  def filter
    @tasks = Task.where(:status => params[:status])
    @tasks = @tasks.paginate(:page => params[:page], :per_page => 10)
  end

  # PUT /tasks/changeStatus/1
  def changeStatus
    @task = Task.find_by_id(params[:id])

    if params[:format].nil?
      @task.status = if @task.status == "inactive" then "active" else "inactive" end
    else
      @task.status = "archived"
    end

    if @task.update_attributes(params[:task])
      redirect_to root_path
    else
      redirect_to show_path
    end
  end

  # GET /tasks/sortPriority/asc
  def sortPriority
    @tasks = Task.where("status='#{params[:status]}'").order("priority='Urgent' #{params[:ordering]}", "priority='High' #{params[:ordering]}",
                                                             "priority='Medium' #{params[:ordering]}", "priority='Low' #{params[:ordering]}");
    @tasks = @tasks.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /tasks/sortDeadline/desc
  def sortDeadline
    @tasks = Task.where("status='#{params[:status]}'").order("case when  deadline is null then 1 else 0 end", "deadline #{params[:ordering]}")
    @tasks = @tasks.paginate(:page => params[:page], :per_page => 10)
  end

  def exportTask
    @tasks = Task.order(:id)
    if params[:type].nil?
      flash[:warning] = "Choose one of the file formats"
      flash.now
      redirect_to root_path # redirect to root index if no radio button was selected
    else
      filename = "Task_Dump_"+Time.now.strftime("%d/%m/%Y %H:%M").to_s
      if params[:commit] == "download"
        if params[:type] == 'CSV'
          send_data @tasks.to_csv, :filename => filename+".csv"
        else
          send_data @tasks.to_xml, :type => 'text/xml; charset=UTF-8;', :filename => filename+".xml"
        end
      else
        if params[:email].blank?
          flash[:warning] = "Please enter a valid email address"
        else
          begin
            if params[:type] == 'CSV'
              MyMailer.attached_doc_mail(params[:email], @tasks.to_csv, filename+".csv").deliver
              flash[:success] = "Mail successfully sent"
              flash.now
            else
              MyMailer.attached_doc_mail(params[:email], @tasks.to_xml, filename+".xml").deliver
              flash[:success] = "Mail successfully sent"
              flash.now
            end
          rescue Exception => e
            flash[:danger] = "Problem in sending the mail , Please re-check your email address"
          end
          redirect_to root_path # redirect to root index after email got sent
        end
      end
    end
  end
  #
  # # DELETE /tasks/1
  # # DELETE /tasks/1.json
  # def destroy
  #   # @task = Task.find(params[:id])
  #   # @task.destroy
  #   #
  #   # respond_to do |format|
  #   #   format.html { redirect_to tasks_url }
  #   #   format.json { head :no_content }
  #   # end
  # end
end
