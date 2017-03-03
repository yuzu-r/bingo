FactoryGirl.define do
  factory :game do
    sequence(:name) {|n| "game number {n}"}
  end
end