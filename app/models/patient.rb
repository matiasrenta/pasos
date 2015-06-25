class Patient < ActiveRecord::Base
  belongs_to :state
  has_many :payments
  has_many :services
  has_many :fixed_therapies, :dependent => :destroy
  has_many :time_ranges, :dependent => :nullify
  has_many :cancellations

  validates_presence_of :nombre, :fecha_nacimiento, :nombre_padre, :nombre_madre, :costo_terapia, :saldo, :state_id, :nombre_empresa, :direccion, :colonia, :delegacion, :cp, :ciudad, :email_empresa, :rfc
  validates_presence_of :motivo_alta, :if => "!fecha_alta.blank?"
  validates_presence_of :cel_padre, :if => "cel_madre.blank?", :message => "Debe ingresar algún celular"
  validates_presence_of :forced_therapy_cost, :forced_valoracion_cost, :forced_visita_cost, :if => :tarifa_especial, :message => "Si es tarifa especial no puede estar en blanco"
  validate :recibo_donativo do
    errors.add(:recibo_donativo, "no puede ser Donativo y Factura") if recibo_donativo && factura
  end
  validate :state do
    errors.add(:state, "Si tiene fecha de alta debe inactivarlo") if state == State.active && fecha_alta
  end

  before_validation :set_saldo_and_therapy_cost
  after_save :destroy_fixed_therapies_and_services, :if => "state_id_changed? && inactive?"

  scope :ordered, order(:nombre)

  def costo_terapia_with_tax
    factura ? costo_terapia * Settings.mas_iva : costo_terapia
  end

  private

  def set_saldo_and_therapy_cost
    self.saldo = 0 if !saldo
    self.costo_terapia = 0 if !costo_terapia
  end

  def destroy_fixed_therapies_and_services
    fixed_therapies.destroy_all
    services.from_date(Date.tomorrow).destroy_all
  end


end
