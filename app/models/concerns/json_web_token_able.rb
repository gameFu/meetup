module JsonWebTokenAble
  extend ActiveSupport::Concern

  def to_jwt(exp = 1.months.from_now.to_i)
    playload = {
      self.class.name.downcase => {
        user_id: self.id
      },
      "exp" => exp
    }
    JWT.encode playload, Rails.application.secrets['jwt_secret'], Rails.application.secrets['jwt_algorithm']
  end
end
