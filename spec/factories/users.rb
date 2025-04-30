FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "#{Faker::Internet.password(min_length: 6, mix_case: true, special_characters: false)}1" }
    password_confirmation { password }
    nickname { Faker::Name.first_name }
    name_kanji { '太郎' }
    surname_kanji { '山田' }
    name_katakana { 'タロウ' }
    surname_katakana { 'ヤマダ' }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
