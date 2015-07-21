require 'rails_helper'

describe 'edit a storybook', type: :feature do

  before do
    @user = User.create!(user_attributes)
    sign_in(@user)
    @story1 = @user.stories.create!(story_attributes(title: 'Story 1'))
    @story2 = @user.stories.create!(story_attributes(title: 'Story 2'))
    @story3 = @user.stories.create!(story_attributes(title: 'Story 3'))
  end

  it 'updates the storybooks and shows the updated attributes' do
    storybook = @user.storybooks.create!(storybook_attributes)

    visit storybook_url(storybook)

    click_link 'Edit this storybook'

    expect(current_path).to eq(edit_storybook_path(storybook))
    expect(page).to have_field('Title')
    expect(page).to have_field('Description')
    expect(page).to have_field('Cover')
    expect(page).to have_link('Publish this storybook')
    expect(page).to have_link('Delete this storybook')


    fill_in 'Title', with: 'Updated Title'
    fill_in 'Description', with: 'Updated description'
    attach_file 'Cover', 'spec/support/uploads/redsherpalogo3.png'
    check(@story1.title)
    check(@story2.title)

    click_button 'Update my storybook'

    expect(current_path).to eq(storybook_path(storybook))
    expect(page).to have_text('Updated Title')
    expect(page).to have_text('Updated description')
    expect(page).to have_selector("img[src$='#{storybook.cover_url}']")
    expect(page).to have_text(@story1.title)
    expect(page).to have_text(@story2.title)
    expect(page).not_to have_text(@story3.title)
  end

  it 'does not update a storybook with a blank title' do
    storybook = @user.storybooks.create!(storybook_attributes)

    visit storybook_url(storybook)

    click_link 'Edit this storybook'

    expect(current_path).to eq(edit_storybook_path(storybook))
    expect(page).to have_field('Title')
    expect(page).to have_field('Description')
    expect(page).to have_field('Cover')
    expect(page).to have_link('Publish this storybook')
    expect(page).to have_link('Delete this storybook')


    fill_in 'Title', with: ' '
    fill_in 'Description', with: 'Updated description'
    attach_file 'Cover', 'spec/support/uploads/redsherpalogo3.png'
    click_button 'Update my storybook'

    expect(page).to have_text('There was a problem updating your storybook.  Please try again.')
  end

  it 'does not update a storybook with an invalid cover file' do
    storybook = @user.storybooks.create!(storybook_attributes)

    visit storybook_url(storybook)

    click_link 'Edit this storybook'

    attach_file 'Cover', 'spec/support/uploads/sherpa.pdf'
    click_button 'Update my storybook'

    expect(page).to have_text('There was a problem updating your storybook.  Please try again.')
  end

end