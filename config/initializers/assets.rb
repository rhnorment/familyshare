%w(static
    users
    sessions
    storybooks
    stories
    relationships
    activities
    devise
    active_admin
    errors
    password_resets).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.css", "#{controller}.js"]
end