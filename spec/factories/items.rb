FactoryBot.define do
  factory :item do
    item_name { 'MyString' }
    description { 'MyText' }
    price { 1000 }
    category_id { 2 }
    condition_id { 2 }
    ship_cost_id { 2 }
    prefecture_id { 2 }
    delivery_time_id { 2 }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec/fixtures/sample1.png')), filename: 'sample1.png',
                        content_type: 'image/png')
    end
  end
end
