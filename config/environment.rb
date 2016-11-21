# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Project::Application.initialize!

file = File.open("/Users/baljeet/Documents/code/personal/ses.txt")
ENV["SES_SMTP_USERNAME"] = file.readline.strip
ENV["SES_SMTP_PASSWORD"] = file.readline
