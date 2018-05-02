class Addon < ApplicationRecord
  belongs_to :dish
  belongs_to :ingredient
  has_many :addons
end
