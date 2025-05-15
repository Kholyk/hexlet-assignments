# frozen_string_literal: true

require 'application_system_test_case'

# BEGIN
class PostsTest < ApplicationSystemTestCase
  def setup
    @post = posts(:one)
  end

  test 'visiting index' do
    visit posts_url
    assert_selector 'h1', text: 'Posts'
  end

  test 'creating a post' do
    visit posts_url
    click_on 'New Post'

    assert_selector 'h1', text: 'New post'

    fill_in 'Title', with: @post.title
    fill_in 'Body', with: @post.body

    click_on 'Create'
    assert_text 'Post was successfully created.'
  end

  test 'updating a post' do
    visit posts_url
    click_on 'Edit', match: :first
    assert_selector 'h1', text: 'Editing post'

    fill_in 'Title', with: 'Edited title'
    click_on 'Update'
    assert_text 'Post was successfully updated.'
    assert_text 'Edited title'
  end

  test 'destroy a post' do
    visit posts_url

    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Post was successfully destroyed.'
  end
end
# END
