OpenAI.configure do |config|
    config.access_token = Rails.application.credentials.chatgpt.api_key 
    # paste your key
end