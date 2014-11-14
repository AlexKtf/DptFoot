class Department < ActiveRecord::Base
  has_many :places
  has_many :participations, through: :places

  def slug
    "#{id}-#{name.parameterize}"
  end

  def image
    ActionController::Base.helpers.asset_path("department-#{self.code}.jpeg")
  end
end
