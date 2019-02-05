class Message < ApplicationRecord
    has_rich_text :content

    has_one :post

    accepts_nested_attributes_for :post
end
