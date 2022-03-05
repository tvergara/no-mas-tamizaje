class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum campus: ['Campus Casa Central', 'Campus Oriente', 'Campus San Joaquín',
                'Campus Lo Contador', 'Campus Villarica', 'Actividad fuera del Campus']
  enum uc_member_type: ['Profesional', 'Académico', 'Administrativo',
                        'Estudiante Pregrado', 'Novato', 'Estudiante Magíster',
                        'Estudiante Doctorado', 'Becado de Especialidades de Salud',
                        'Postdoctorado', 'Colaborador Externo', 'Visitante']
  has_many :scraping_days, class_name: 'UserScrapingDay', dependent: :destroy
  scope :scrapes_today, -> { joins(:scraping_days).where('weekday = ?', Time.new.wday) }

  def uc_username
    email.split('@').first
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  uc_password            :string
#  rut                    :string
#  name                   :string
#  phone_number           :string
#  uc_member_type         :integer
#  campus                 :integer
#  campus_place           :string
#  active                 :boolean
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
