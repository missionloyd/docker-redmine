require 'openssl'
require 'rack'

class GithubWebhooksVerifier
  def initialize(app, secret)
    @app = app
    @secret = secret
  end

  def call(env)
    request = Rack::Request.new(env)
    payload_body = request.body.read
    signature = 'sha256=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @secret, payload_body)

    unless Rack::Utils.secure_compare(signature, env['HTTP_X_HUB_SIGNATURE_256'])
      return [403, {'Content-Type' => 'text/plain'}, ['Invalid signature']]
    end

    request.body.rewind  # In case the application wants to read it again
    @app.call(env)
  end
end
