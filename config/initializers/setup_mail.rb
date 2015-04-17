if Rails.env.development? || Rails.env.production?
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	:enable_starttls_auto => true,
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :domain => 'heroku.com',
    :authentication => :plain,
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD']
}
end