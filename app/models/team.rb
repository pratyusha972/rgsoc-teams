class Team < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :roles
  has_many :members,  class_name: 'User', through: :roles, source: :member
  has_many :students, class_name: 'User', through: :roles, source: :member, conditions: { roles: { name: 'student' } }
  has_many :coaches,  class_name: 'User', through: :roles, source: :member, conditions: { roles: { name: 'coach'   } }
  has_many :mentors,  class_name: 'User', through: :roles, source: :member, conditions: { roles: { name: 'mentor'  } }

  has_many :repositories
  has_many :activities
end