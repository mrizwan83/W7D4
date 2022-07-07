# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  details    :text             not null
#  private    :boolean          not null
#  completed  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
class Goal < ApplicationRecord
  validates :title, :details, presence: true

  belongs_to :user,
  class_name: :User,
  foreign_key: :user_id

  has_many :cheers,
  class_name: 'Cheer',
  foreign_key: goal_id
end
