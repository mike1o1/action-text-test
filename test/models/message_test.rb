require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can update post from within message" do
    message = Message.create!(title: "Test")
    post = message.create_post!

    message.reload

    # test updating post directly
    message.update!(post_attributes: { content: "Test content", id: post.id })

    assert_equal "Test content", message.post.content.to_plain_text

    # reload and see if things persisted
    message.reload

    # this fails. The content is never saved
    assert_equal "Test content", message.post.content.to_plain_text
  end

  test "can update post from within a message with another attribute" do
    message = Message.create!(title: "Test")
    post = message.create_post!

    message.reload

    # test updating post directly
    message.update!(post_attributes: { content: "Test content", id: post.id, title: "New title" })

    assert_equal "Test content", message.post.content.to_plain_text

    # reload and see if things persisted
    message.reload

    assert_equal "Test content", message.post.content.to_plain_text
  end
end
