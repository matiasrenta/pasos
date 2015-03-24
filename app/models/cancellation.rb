class Cancellation < ActiveRecord::Base
  belongs_to :patient
  belongs_to :therapist
  belongs_to :user
end
