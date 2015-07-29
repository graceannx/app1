class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  class AddUserAvatar < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
  end
end


  mount_uploader :avatar, AvatarUploader 


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

 # Setup accessible (or protected) attributes for your model


  validates_presence_of   :avatar
  validates_integrity_of  :avatar
  validates_processing_of :avatar


  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
 def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  } # etc.

 def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  else
    if conditions[:username].nil?
      where(conditions).first
    else
      where(username: conditions[:username]).first
    end
  end
end


class AddUserAvatar < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
  end
end


end
