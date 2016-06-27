FactoryGirl.define do
  factory :owner do
    name "fred"
    age 29
    # description { name + age }
    sequence(:email) { |n| "mr_#{n}@example.com" }

    factory :owner_with_five_dogs do
      name "many_dogs fred"

      after(:create) do |owner, evaluator|
        create_list(:dog, 5, owner: user)
      end
    end

    factory :owner_with_dogs do
       transient do 
         dog_count 3
       end

     # FactoryGirl.create()
      after(:create) do |owner, evaluator|
        create_list(:dog, evaluator.dog_count, owner: user)
      end
    end

    trait :old_female do
      name "mary"
      age 89
    end

    trait :outlander do
      address "Somewhere in Kentucky"
    end

    trait :billy do
      name "billy"
    end

    factory :old_female_owner, traits: [:old_female]
    factory :old_female_outlander, traits: [:old_female, :outlander]
    factory :billy_the_outlander, traits: [:billy, :outlander]

    factory :owner_billy do
      billy
    end
  end
end