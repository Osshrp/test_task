FactoryGirl.define do
  factory :calendar do
    user

    transient do
      events_count 2
    end

    factory :calendar_with_events do
      after(:create) do |calendar, evaluator|
        (0..evaluator.events_count).each do |i|
          calendar.events << create(:event, user: calendar.user)
        end
      end
    end
  end
end
