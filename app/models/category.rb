class Category < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }

  DEFAULT_CATEGORIES = [
    { name: 'Pediatrician' },
    { name: 'Dermatologist' },
    { name: 'Urologist' },
    { name: 'Family medicine' },
    { name: 'Psychiatrist' },
    { name: 'Dentist' },
    { name: 'Cardiologist' },
    { name: 'Neurologist' },
    { name: 'Rheumatologist' },
    { name: 'Orthopaedist' },
    { name: 'Gynecologist' },
    { name: 'Endocrinologist' }
  ].freeze

  has_many :doctors, dependent: :destroy
end
