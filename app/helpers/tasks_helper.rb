module TasksHelper
  def datePrint(date)
    if date.nil?
      return ""
    end
    date.strftime("%d %b %Y").to_s
  end
end
