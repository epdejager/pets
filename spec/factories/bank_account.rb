FactoryGirl.define do
  factory :bank_account do
    name "Platinum cheque"
    value "132"
    owner # association :owner
  end
end
