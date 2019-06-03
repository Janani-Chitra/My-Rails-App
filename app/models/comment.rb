class Comment < ActiveRecord::Base
  belongs_to :post
  validates_presence_of :commenter
  after_destroy :log_destroy_action

  def log_destroy_action
    puts 'Post destroyed'
  end
end
