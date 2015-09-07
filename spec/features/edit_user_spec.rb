require 'rails_helper'

describe 'Editing a user', type: :feature do

  it 'updates the user and shows the user updated details' do
    user = User.create!(user_attributes)

    sign_in(user)

    visit user_url(user)

    click_link 'Edit'

    expect(current_path).to eq(edit_user_path(user))

    expect(find_field('Name').value).to eq(user.name)

    fill_in 'Name', with: 'Updated User Name'

    click_button 'Update'

    expect(page).to have_text('Updated User Name')
    expect(page).to have_text('Account successfully updated!')
  end

  it 'does not update the user if invalid' do
    user = User.create!(user_attributes)

    sign_in(user)

    visit edit_user_url(user)

    fill_in 'Name', with: ' '

    click_button 'Update'

    expect(page).to have_text("can't be blank")
  end

end