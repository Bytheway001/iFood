class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :addons, dependent: :destroy
  do_not_validate_attachment_file_type :photo
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>",avatar: '32x32' }, default_url: "/missing.png"
  accepts_nested_attributes_for :addons, reject_if: :all_blank, allow_destroy: true
end
