class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :resumes
  #attr_accessor :login
  #
  # def login=(login)
  #   @login = login
  # end
  #
  # def login
  #   @login || self.username || self.email
  # end

  def admin?
    is_admin
  end
end
