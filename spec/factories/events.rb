FactoryGirl.define do
  sequence :title do |n|
    "Test title#{n}"
  end

  factory :event do
    user
    title
    start_date "2017-08-19 11:31:45"
    end_date "2017-08-19 11:31:45"
  end

  factory :invalid_event, class: 'Event' do
    title nil
    start_date nil
  end
end
