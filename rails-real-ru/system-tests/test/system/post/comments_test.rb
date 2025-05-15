require 'application_system_test_case'

class Post::CommentsTest < ApplicationSystemTestCase
  def setup
    @post = posts(:one)

    visit posts_url
    click_on 'Show', match: :first

    @body_textarea = find_field(name: 'post_comment[body]')
  end

  test 'visiting the index' do
    assert_text 'Comments'
  end

  test 'creating comment' do
    @body_textarea.fill_in with: 'New comment'
    click_on 'Create Comment'
    assert_text 'New comment'
    assert_text 'was successfully'
  end

  test 'updating comment' do
    click_on 'Edit', match: :first
    textarea = find_field(name: 'post_comment[body]')
    textarea.fill_in with: 'Edited comment'

    click_on 'Update Comment'
    assert_text 'successfully'
    assert_text 'Edited comment'
  end

  test 'destroy comment' do
    page.accept_confirm do
      click_on 'Delete'
    end

    assert_text 'en.posts.comments.success'
  end
end
