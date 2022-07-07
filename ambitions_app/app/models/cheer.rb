# == Schema Information
#
# Table name: cheers
#
#  id         :bigint           not null, primary key
#  giver_id   :integer          not null
#  goal_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cheer < ApplicationRecord
  validates :giver_id, :goal_id, presence: true
  validates :goal_id, uniqueness: { scope: :giver_id }

  belongs_to :giver,
  class_name: 'User',
  foreign_key: giver_id

  belongs_to :goal,
  class_name: 'Goal',
  foreign_key: goal_id




end
