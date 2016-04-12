FactoryGirl.define do
  factory :transaction do
    invoice nil
    credit_card_number 1
    credit_card_expiration_date "MyString"
    result "MyString"
    created_at "2016-04-11 22:03:32"
    updated_at "2016-04-11 22:03:32"
  end
end
