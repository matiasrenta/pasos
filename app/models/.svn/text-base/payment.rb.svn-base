class Payment < ActiveRecord::Base
  belongs_to :patient

  validates_presence_of :patient_id, :importe

  after_save :calculate_patient_saldo, :on => :create
  after_destroy :calculate_patient_saldo_destroy
  private

  def calculate_patient_saldo
    self.patient.saldo = self.patient.saldo + self.importe
    self.patient.save!
  end

  def calculate_patient_saldo_destroy
    self.patient.saldo = self.patient.saldo - self.importe
    self.patient.save!
  end

end
