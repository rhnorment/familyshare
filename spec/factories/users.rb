# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  reset_token     :string(255)
#  reset_sent_at   :datetime
#  created_at      :datetime
#  updated_at      :datetime


FactoryGirl.define do

  factory :user do
    name                    'Example User'
    email                   'user@example.com'
    password                'secret'
    password_confirmation   'secret'

    # factories for invitations
    factory :user_as_self do
      name                  'Self User'
      email                 'self@example.com'
    end

    factory :user_as_member do
      name                  'Member User'
      email                 'member@example.com'
    end

    factory :user_to_find do
      name                  'Find User'
      email                 'find_me@example.com'
    end

    factory :user_already_relative do
      name                  'Relative User'
      email                 'relative@example.com'
    end

    # factories for relationships:
    factory :user_1 do
      name                  'User1 User'
      email                 'user_1@example.com'
    end

    factory :user_2 do
      name                  'User2 User'
      email                 'user_2@example.com'
    end

    factory :user_3 do
      name                  'User3 User'
      email                 'user_3@example.com'
    end

    factory :user_4 do
      name                  'User4 User'
      email                 'user_4@example.com'
    end

    # factory for storybooks:
    factory :user_with_storybooks do
      transient do
        storybooks_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:storybook, evaluator.storybooks_count, user: user)
      end
    end

    # factory for stories
    factory :user_with_stories do
      transient do
        stories_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:story, evaluator.stories_count, user: user)
      end
    end
  end

end