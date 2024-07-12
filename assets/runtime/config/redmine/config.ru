# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
require_relative 'lib/github_webhooks_verifier'

map ENV['RAILS_RELATIVE_URL_ROOT'] || "/" do
  # Apply the GitHub Webhooks Verifier middleware only to the /github_hook endpoint
  if ENV['REDMINE_SECRET_TOKEN'] 
    map '/github_hook' do
      use GithubWebhooksVerifier, ENV['REDMINE_SECRET_TOKEN'] 
      run RedmineApp::Application
    end
  end

  # Handle all other paths normally
  run RedmineApp::Application
end
