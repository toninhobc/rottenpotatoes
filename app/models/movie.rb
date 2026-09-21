class Movie < ApplicationRecord
    # Definimos uma constante com as classificações aceitas pelo RottenPotatoes
    RATINGS = %w[G PG PG-13 R NC-17].freeze

    # Validações obrigatórias
    validates :title, presence: true
    validates :rating, inclusion: { in: RATINGS }
    validates :release_date, presence: true
end
