require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'json'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Gmail API Ruby Quickstart'
CREDENTIALS_PATH = 'config/google_credentials.json'
TOKEN_PATH = 'token.yaml'

# Authorize credentials
authorize = Google::Auth.configure do |config|
  config.client_id = '117889187961916926013'
  config.client_secret = 'your-client-secret'
  config.scope = Google::Apis::GmailV1::AUTH_GMAIL_SEND
end

# Initialize the Gmail API client
gmail = Google::Apis::GmailV1::GmailService.new
gmail.authorization = authorize

# Prepare the email message
message = Google::Apis::GmailV1::Message.new
message.raw = Base64.urlsafe_encode64("To: daiphatle123@example.com\r\nSubject: Test email\r\n\r\nThis is a test email sent using the Gmail API and the google-api-client gem.\r\n")

# Send the email
gmail.send_user_message('me', message)

puts "Email sent successfully!"