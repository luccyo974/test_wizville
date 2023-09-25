FactoryBot.define do
    factory :student do
      language { "en" }
      has_microphone { true }
    end

    factory :trace do
      score {1}
    end

    factory :activity do
      activity_type {"gretodnempplapuisdry"}
      uuid {"181268"}
      skill { "stoc" }
    end
  end