class User < ApplicationRecord
  has_many :restaurants, dependent: :destroy
  has_many :orders, through: :restaurants
  has_many :pedidos, foreign_key: "user_id", class_name: "Order"
  has_many :notifications, through: :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
  :registerable, :recoverable, 
  :rememberable, :trackable, 
  :validatable, :confirmable, :lockable,
  :omniauthable, omniauth_providers: %i[facebook]


=begin

#<OmniAuth::AuthHash credentials=#<OmniAuth::AuthHash expires=true expires_at=1522617901 token="EAAFkpkKWaDMBAL9KleexXx4rQNl7989tyPdMzlXvI34sbjmTz5ioNsTZAtPRTS4rdRMmfzfkZAXRGaWQO3f5VXswpYM5RTCbvwMhloeD6ZAKGbzatm9Dhbh8qxBpmZBeGItpTzFxnwNNdIxkZCSTKG9jZBELnL75YtB8N7sqlZCrAZDZD"> extra=#<OmniAuth::AuthHash raw_info=#<OmniAuth::AuthHash email="bytheway0708@gmail.com" first_name="Rafael" id="10215611645270759" last_name="Castillo">> info=#<OmniAuth::AuthHash::InfoHash email="bytheway0708@gmail.com" first_name="Rafael" image="http://graph.facebook.com/v2.6/10215611645270759/picture" last_name="Castillo"> provider="facebook" uid="10215611645270759">

=end
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.nombre = auth.info.name
      user.password = Devise.friendly_token[0,20]
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def is_admin?
    self.role==1
  end

  def is_driver?
    self.role==2
  end
end
