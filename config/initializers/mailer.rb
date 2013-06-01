if Rails.env.test?
  ActionMailer::Base.default_url_options = { host: 'www.example.com' }
end
