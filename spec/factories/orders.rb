FactoryBot.define do
  factory name :order do
    association :user, factory: :user
  end
end