Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*' # Update this with the domains you want to allow (e.g., 'http://localhost:3000')
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
    