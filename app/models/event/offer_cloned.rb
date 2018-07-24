require 'ext/hash'

class Event::OfferCloned < Event

  EXTRAS = {
    "maturation"     => :datetime ,
    "maturation_beg" => :datetime ,
    "maturation_end" => :datetime
  }

  jsonb_fields_for :payload, Offer, {extras: EXTRAS}

  validates :uuid           , presence: true
  validates :prototype_uuid , presence: true

  def cast_object
    proto  = Offer.find_by_uuid(prototype_uuid)
    params = valid_params(proto.attributes).merge(payload).without_blanks
    Offer.new(params)
  end

  def tgt_user_uuids
    [user_uuid]
  end

  private

  def valid_params(attributes)
    skips = %w(id uuid created_at updated_at)
    attributes.without(*skips).merge({"status" => "open"})
  end
end
#

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
