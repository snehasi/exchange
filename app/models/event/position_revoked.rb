require 'ext/hash'

class Event::PositionRevoked < Event

  jsonb_fields_for :payload, Position

  validates :uuid       , presence: true
  validates :user_uuid  , presence: true

  jsonb_accessor :jfields, :transfer_uuid => :string

  def cast_object
    Position.new(payload.without_blanks)
  end

  def tgt_user_uuids
    []
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :bigint(8)        not null, primary key
#  event_type   :string
#  event_uuid   :string
#  cmd_type     :string
#  cmd_uuid     :string
#  local_hash   :string
#  chain_hash   :string
#  payload      :jsonb            not null
#  jfields      :jsonb            not null
#  user_uuids   :string           default([]), is an Array
#  tags         :string
#  note         :string
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
