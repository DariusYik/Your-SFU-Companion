OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '401204827996-acrs51tggf2f3llpbgtpvoues113a0r4.apps.googleusercontent.com', 'p3DpEfWJ2ekR8NFudoN3D8Mv', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end