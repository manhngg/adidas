class LoginLog < ApplicationRecord
  enum action_type: { login: 0, logout: 1 }
end
