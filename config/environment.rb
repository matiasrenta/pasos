# Load the rails application
require File.expand_path('../application', __FILE__)

APP_INSTANCE = Rails.root.to_s.split("/").last

case APP_INSTANCE
  when "sys" then
    HOST = "104.131.241.21"
    LOGO = "logo_pasos.jpg"
    NOREPLY_MAIL = "noreply@fundacionpasos.org.mx"
    NOREPLY_FRIENDLY = %{"Pasos" <noreply@fundacionpasos.org.mx>}
    NOREPLY_PASS = "misterio"
    BASE_CURRENCY = "MXN"
  when "test" then
    HOST = "104.131.241.21"
    LOGO = "logo_pasos.jpg"
    NOREPLY_MAIL = "noreply@fundacionpasos.org.mx"
    NOREPLY_FRIENDLY = %{"Pasos" <noreply@fundacionpasos.org.mx>}
    NOREPLY_PASS = "misterio"
    BASE_CURRENCY = "MXN"
  else
    HOST = "localhost:3000"
    LOGO = "logo_pasos.jpg"
    NOREPLY_MAIL = "noreply@fundacionpasos.org.mx"
    NOREPLY_FRIENDLY = %{"Pasos" <noreply@fundacionpasos.org.mx>}
    NOREPLY_PASS = "misterio"
    BASE_CURRENCY = "MXN"
end



# Initialize the rails application
Pru1::Application.initialize!

# Apply patch for date and date input
#require 'lib/column_patch'
#ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(default => '%d/%m/%Y')
#ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(default => '%d/%m/%Y %H:%M')

ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
