require "gmail"
require "hashie"
require "yaml"

mailtitle, mailbody, receiveaddress = ARGV
#sender = Hashie::Mash.load("settings/sender.yml")
sender = YAML.load_file("settings/sender.yml")

gmail = Gmail.new(sender["username"], sender["apppassword"])

message =
  gmail.generate_message do
    to "#{receiveaddress}"
    subject "#{mailtitle}"
    html_part do
      content_type "text/html; charset=UTF-8"
      body "#{mailbody}"
    end
  end

gmail.deliver(message)
gmail.logout

