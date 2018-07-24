require 'rails_helper'

RSpec.describe Event::OfferSellCreated, :type => :model do

  def valid_params(alt = {})
    {
      :salable_position_uuid => SecureRandom.uuid ,
      :cmd_type   => "Test::Offer::Sell"          ,
      :cmd_uuid   => SecureRandom.uuid            ,
      :type       => "Offer::Sell::Fixed"         ,
      :uuid       => SecureRandom.uuid            ,
      :user_uuid  => user.uuid                    ,
      :volume     => 10                           ,
      :price      => 0.6                          ,
      :maturation => BugmTime.now - 1.day
    }.merge(alt)
  end

  let(:user)   { FB.create(:user).user   }
  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.ev_cast
      expect(subject).to be_valid
    end

    it 'prevents calling save' do
      expect {subject.save}.to raise_error(NoMethodError)
    end
  end

  describe "Project" do
    # it "changes the user reserve" do
    #   expect(user.token_available).to eq(1000.0)
    #   expect(Event.count).to eq(2)
    #   obj = subject.ev_cast
    #   user.reload
    #   expect(obj).to be_a(Offer)
    #   expect(Event.count).to eq(3)
    #   expect(User.count).to  eq(1)
    #   expect(user.token_available).to eq(1000.0)
    # end
  end
end #

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
