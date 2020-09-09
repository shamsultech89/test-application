class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  before_validation :mark_profile_as_changed

  scope :created_before, ->(time) do
    where("created_at < ?", time) if time.present?
  end

  def self.created_before_m(time)
    where("created_at < ?", time) if time.present?
  end

  after_touch do |user|
    puts "You have touched an object"
  end

  def self.test_transaction
    transaction do
      User.first.destroy
      User.create!
    end
  end

  def mark_profile_as_changed
    # byebug
    # profile.updated_at_will_change!
  end
end
