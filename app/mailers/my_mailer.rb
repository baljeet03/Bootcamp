class MyMailer < ActionMailer::Base
  default from: "baljeet@freshdesk.com"
  def attached_doc_mail(user, data, fileName)
    attachments[fileName] = data
    mail(to: user, subject: "Task Dump", body: "")
  end

  def simple_mail(user)
    mail(to: user)
  end
end
