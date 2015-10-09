class User < ActiveRecord::Base
  belongs_to :pricetype

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :activated, ->{ where(activated: true)}
  scope :unactivated, ->{ where(activated: false)}

end
