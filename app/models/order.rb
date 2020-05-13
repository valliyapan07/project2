class Order < ActiveRecord::Base
  has_many :orderitems
  belongs_to :user

  def ist(time)
    time.in_time_zone(TZInfo::Timezone.get("Asia/Kolkata")).to_s(:short)
  end
end
