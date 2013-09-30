class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :coursera_id, :name

  validates_presence_of :name
  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :studies
  has_many :region_sets
  has_many :regions

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  #def update_with_password(params, *options)
  #  if encrypted_password.blank?
  #    update_attributes(params, *options)
  #  else
  #    super
  #  end
  #end

  def update_with_password(params={})

    # Don't save passwords if they are blank
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update_attributes(params)
    clean_up_passwords

    result
  end


  def self.search(term)
    q = "%#{term}%"
    User.where("name like ? or username like ? or email like ?", q, q, q)
    # Study.where("name like ? or description like ?", q, q)
  end

end
