class Patient < ActiveRecord::Base
  has_one :user, :as => :utilizador
end
