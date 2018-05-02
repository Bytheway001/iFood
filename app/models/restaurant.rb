class Restaurant < ApplicationRecord
	belongs_to :user
	has_many :dishes
	has_many :orders, dependent: :destroy
	has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>",avatar: '32x32' }, default_url: "/images/:style/missing.png"
	do_not_validate_attachment_file_type :logo, validate_media_type: false

	def quality
		stars=0;
		orders=0
		self.orders.each do |order|
			orders=orders+1
			stars=stars+order.stars
		end
		if orders==0
			return 0
		else
			return (stars/orders).to_s
		end
		
	end

end
