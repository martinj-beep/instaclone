# class User < ApplicationRecord
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :validatable

#          has_many :posts
#          has_many :likes
#          has_many :comments
#          has_one_attached :avatar
#          before_create :randomize_id
#          private
#          def randomize_id
#            begin
#             self.id = SecureRandom.random_number(1_000_000_000)
#            end while User.where(id: self.id).exists?
#          end
# end


class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :likes
  has_many :comments
  has_one_attached :avatar

  before_create :randomize_id

  def self.ransackable_attributes(auth_object = nil)
    [ "username", "email", "created_at", "bio" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "posts", "comments" ]
  end

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while User.where(id: self.id).exists?
  end

  # 2:19
  # for admin functionality
  # enum role: { user: 0, admin: 1 }
  # after_initialize :set_default_role, if: :new_record?
  # def set_default_role
  #   self.role ||= :user
  # end
end
