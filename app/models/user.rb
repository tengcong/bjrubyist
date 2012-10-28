class User < ActiveRecord::Base
  rolify

  extend OmniauthCallbacks

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :memberships, :foreign_key => "member_id"
  has_many :events, :through => :memberships, :foreign_key => "member_id"

  has_many :authorizations, :dependent => :destroy

  # omniauth config
  def bind_service(response)
    provider = response["provider"]
    uid = response["uid"]
    authorizations.create(:provider => provider , :uid => uid )
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update_attributes(params, *options)

    clean_up_passwords
    result
  end

end
