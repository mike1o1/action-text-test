require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "can update post from within message" do
    message = Message.create!(title: "Seasons")
    post = message.create_post!

    # test updating post directly
    message.update!(post_attributes: { content: "Test content", id: post.id })

    # it appears that everything updated?
    assert_equal "Test content", message.post.content.to_plain_text

    # reload and double check
    message.reload

    # this fails. The content is never saved
    assert_equal "Test content", message.post.content.to_plain_text
  end

  test "can update post from within a message with another attribute" do
    message = Message.create!(title: "Seasons")
    post = message.create_post!

    # test updating post directly
    message.update!(post_attributes: { content: "Test content", id: post.id, title: "New title" })

    assert_equal "Test content", message.post.content.to_plain_text

    # reload and see if things persisted
    message.reload

    assert_equal "Test content", message.post.content.to_plain_text
  end

  test "can update post from within a message and save rich text" do
    message = Message.create!(title: "Seasons")
    post = message.create_post!

    message.update!(post_attributes: { content: "Test content", id: post.id })

    assert_equal "Test content", message.post.content.to_plain_text

    # save manually post and reload message
    message.post.save
    message.reload

    assert_equal "Test content", message.post.content.to_plain_text
  end

  test "can update has_many from within a message and save rich text" do
    message = Message.create!(title: "Seasons")
    child_post = message.child_posts.create!

    message.update!(child_posts_attributes: { 
        content: "Test content", 
        id: child_post.id
      }
    )

    assert_equal "Test content", child_post.content.to_plain_text

    child_post.reload

    assert_equal "Test content", child_post.content.to_plain_text
  end

  test "can update has_many from within a message and save rich text with other attributes" do
    message = Message.create!(title: "Seasons")
    child_post = message.child_posts.create!

    message.update!(child_posts_attributes: { 
        content: "Test content", 
        id: child_post.id, 
        title: "Test" 
      }
    )

    assert_equal "Test content", child_post.content.to_plain_text

    child_post.reload

    assert_equal "Test content", child_post.content.to_plain_text
  end
end
