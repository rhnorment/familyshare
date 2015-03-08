require 'spec_helper'

describe 'viewing the list of users' do

  it 'shows the users' do
    user1 = User.create!(user_attributes(name: 'Larry', email: 'larry@example.com'))
    user2 = User.create!(user_attributes(name: 'Moe',   email: 'moe@example.com'))
    user3 = User.create!(user_attributes(name: 'Curly', email: 'curly@example.com'))

    sign_in(user1)

    visit users_url

    expect(page).to have_text(user1.name)
    expect(page).to have_text(user2.name)
    expect(page).to have_text(user3.name)
    # expect(page).to have_text(time_ago_in_words(user1.created_at))
    # expect(page).to have_text(time_ago_in_words(user2.created_at))
    # expect(page).to have_text(time_ago_in_words(user3.created_at))
  end

end