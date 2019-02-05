class Message < ApplicationRecord
    has_rich_text :content

    # also happens with `has_many`
    has_one :post

    has_many :child_posts, class_name: "Post"

    accepts_nested_attributes_for :post
    accepts_nested_attributes_for :child_posts
end
