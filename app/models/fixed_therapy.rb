class FixedTherapy < ActiveRecord::Base
  belongs_to :patient
  belongs_to :therapist

  validates_presence_of :patient_id, :therapist_id, :fecha_inicio
end
