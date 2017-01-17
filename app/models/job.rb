class Job < ApplicationRecord
  has_many :resumes
  validates :title,:city, :wage_lower_bound, :wage_upper_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0 }
  validates :contact_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "%{value} 不是有效的email地址,请检查!"}
  #上一行代码是抄forrest-党明同学的，format里没看懂是怎么实现的。

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  scope :published, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC') }

  def check_wage
    if wage_upper_bound.to_i <= wage_lower_bound.to_i
      errors.add(:wage_upper_bound, "最高薪资要超过最低薪资")
    end
  end
#上一段代码是抄forrest-党明同学的。实现了，薪资上限必须大于薪资下限。

end
