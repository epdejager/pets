FactoryGirl.define do
  factory :bank_account do
    name "Platinum cheque"
    value "132"
    owner # association :owner
    #association :owner, :factory => owner_with_five_dogs
  end
end
