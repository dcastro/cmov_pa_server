class Patient < ActiveRecord::Base
  has_one :user, :as => :utilizador
  has_many :appointments
end
