class Offer::Buy::Bid < Offer::Buy

  before_validation :default_values

  def side() "bid" end
  alias_method :xtag, :side

  def qualified_counteroffers(cross_type)
    return Offer.none unless self.is_open?
    base = match.open.overlaps(self)
    case cross_type
      when :expand  then base.is_buy_ask.align_complement(self)
      when :realloc then base.is_sell_bid.align_equal(self)
      else Offer.none
    end
  end
  alias_method :counters, :qualified_counteroffers

  private

  def default_values
    self.type              ||= 'Bid::GitHub'
    self.stm_status        ||= 'open'
    self.price             ||= 0.10
    self.maturation_range  ||= Time.now+1.minute..Time.now+1.week
  end

end

# == Schema Information
#
# Table name: offers
#
#  id                 :integer          not null, primary key
#  type               :string
#  repo_type          :string
#  user_id            :integer
#  reoffer_parent_id  :integer
#  parent_position_id :integer
#  volume             :integer          default(1)
#  price              :float            default(0.5)
#  poolable           :boolean          default(TRUE)
#  aon                :boolean          default(FALSE)
#  status             :string
#  expiration         :datetime
#  maturation_range   :tsrange
#  jfields            :jsonb            not null
#  exref              :string
#  uuref              :string
#  stm_bug_id         :integer
#  stm_repo_id        :integer
#  stm_title          :string
#  stm_status         :string
#  stm_labels         :string
#  stm_xfields        :hstore           not null
#  stm_jfields        :jsonb            not null
#
