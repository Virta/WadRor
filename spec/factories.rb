FactoryGirl.define do

  factory :user do
    username 'Teuvo'
    password 'SadastaN0llaan'
    password_confirmation 'SadastaN0llaan'
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name 'Anonyeer'
    year 1880
  end

  factory :style do
    name 'AnonyStyle'
    description 'N/A'
  end

  factory :beer do
    name 'AnonyBeer'
    brewery
    style
  end

end