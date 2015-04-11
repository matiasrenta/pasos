# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150410234931) do

  create_table "assessments", :force => true do |t|
    t.integer  "patient_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "assessment_type"
  end

  create_table "cancellations", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "therapist_id"
    t.date     "cancel_from_fecha"
    t.date     "cancel_to_fecha"
    t.integer  "service_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "motivo"
  end

  create_table "dayly_service_creations", :force => true do |t|
    t.date     "last_creation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "until_date"
  end

  create_table "fixed_therapies", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "therapist_id"
    t.date     "fecha_inicio"
    t.date     "fecha_fin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "timetable_since"
  end

  create_table "nominas", :force => true do |t|
    t.integer  "therapist_id"
    t.date     "fecha"
    t.string   "concepto"
    t.float    "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", :force => true do |t|
    t.string   "nombre"
    t.string   "nombre_padre"
    t.string   "nombre_madre"
    t.string   "tel_casa"
    t.string   "cel_padre"
    t.string   "cel_madre"
    t.string   "email"
    t.date     "fecha_ingreso"
    t.boolean  "recibo_donativo"
    t.boolean  "factura"
    t.string   "nombre_empresa"
    t.string   "direccion"
    t.string   "colonia"
    t.string   "delegacion"
    t.string   "cp"
    t.string   "ciudad"
    t.string   "email_empresa"
    t.decimal  "costo_terapia",          :precision => 10, :scale => 2
    t.decimal  "saldo",                  :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state_id"
    t.date     "fecha_alta"
    t.text     "motivo_alta"
    t.string   "rfc"
    t.string   "referente"
    t.date     "fecha_nacimiento"
    t.text     "diagnostico"
    t.boolean  "tarifa_especial"
    t.float    "forced_therapy_cost"
    t.float    "forced_valoracion_cost"
    t.float    "forced_visita_cost"
  end

  create_table "payments", :force => true do |t|
    t.integer  "patient_id"
    t.decimal  "importe",     :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "pdf_text"
    t.integer  "nro_recibo"
  end

  create_table "presences", :force => true do |t|
    t.integer  "therapy_id"
    t.datetime "fecha_hora"
    t.decimal  "importe",           :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "presenscable_id"
    t.string   "presenceable_type"
  end

  create_table "roles", :force => true do |t|
    t.string   "i18n_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "services", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "therapist_id"
    t.datetime "from_fecha_hora"
    t.datetime "to_fecha_hora"
    t.decimal  "importe",            :precision => 10, :scale => 2
    t.text     "datos_escuela"
    t.string   "nombre_profesor"
    t.string   "grado_escolar"
    t.boolean  "asistido"
    t.boolean  "cancelado"
    t.text     "motivo_cancelacion"
    t.integer  "service_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "special"
    t.integer  "cancellation_id"
    t.integer  "nomina_id"
    t.float    "therapist_cost"
  end

  create_table "special_dates", :force => true do |t|
    t.integer  "therapy_id"
    t.datetime "fecha_hora"
    t.boolean  "cancellation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "therapies", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "therapist_id"
    t.date     "fecha_inicio"
    t.integer  "sesiones_semanales"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "therapist_schedules", :force => true do |t|
    t.integer  "therapist_id"
    t.integer  "dia"
    t.integer  "hora"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "therapists", :force => true do |t|
    t.string   "nombre"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "timetable_since"
    t.float    "therapy_cost"
    t.float    "valoracion_cost"
    t.float    "visita_cost"
  end

  create_table "therapy_schedule_joins", :id => false, :force => true do |t|
    t.integer  "therapy_id"
    t.integer  "therapist_schedule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_ranges", :force => true do |t|
    t.integer  "therapist_id"
    t.integer  "day"
    t.integer  "from_hour"
    t.integer  "from_minute"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "working_time"
    t.boolean  "taken"
    t.integer  "patient_id"
    t.integer  "fixed_therapy_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.integer  "state_id"
    t.string   "name"
    t.string   "last_name"
    t.string   "mother_last_name"
    t.string   "work_phone"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.text     "html_menu_items"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
