class Post < ApplicationRecord
  belongs_to :user
  #carrierWave
  mount_uploader :image , AvatarUploader
  mount_uploaders :images , AvatarUploader
  serialize :images , JSON

  #paperclip
  # has_attached_file :avatar
  has_attached_file :avatar , styles: {medium: "300x100>", thumb: "100x100>"}
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  #active storage
  has_one_attached :photo
  has_many_attached :photos

  #drag and drop
  has_one_attached :feature_image
  has_many_attached :feature_images

  

  validates :title,presence: true

  before_validation :check_before_validation
  after_validation :validating

  before_save :post_before_save, :if => Proc.new { |title| title == "pop"}
  around_save :post_around_save 
  before_create :post_before_create

  around_create :post_around_create
  after_create :post_after_create
  after_save :post_after_save
  after_commit :post_after_commit
  after_rollback :post_after_rollback

  before_update :post_before_update
  # around_update :post_around_update
  after_update :post_after_update

  before_destroy :post_before_destroy
  # around_destroy :post_around_destroy
  after_destroy :post_after_destroy

  after_initialize :post_after_initialize
  after_find :post_after_find
  after_touch :post_after_touch

  # after_create_commit :post_after_commit1
  # after_update_commit :post_after_commit1


   scope :with_title_length, ->(length = 5) {where("LENGTH(title)> ?",length)}

  private


    def check_before_validation
      puts "before validation"
    end

    def validating 
      puts "after validation"
    end

    def post_before_save
      puts "post before save"
    end

    def post_around_save
      puts "post in around save"
      yield
      puts "post out around save"
    end

    def post_before_create
      puts "post before create"
    end

    def post_around_create
      puts "post in around_create"
      yield
      puts "post out around create"
    end
    def post_after_create
      puts" post after create"
    end

    def post_after_save
      puts "post after save"
    end

    def post_after_commit
      puts "post after commit"
    end

    def post_after_rollback
      puts "post after rollback"
    end

    def post_before_update
      puts "post before update"
    end

    def post_around_update
      puts "post around update"
    end

    def post_after_update
      puts "post after update"
    end

    def post_before_destroy
      puts "post before destroy"
    end

    def post_around_destroy
      puts "post around destroy"
    end

    def post_after_destroy
      puts "post_after_destroy"
    end

    def post_after_initialize
      puts "post after initialize"
    end

    def post_after_find
      puts "post after find"
    end

    def post_after_touch
      puts "post after touch"
    end
  # after_initialize do |post|
  #   puts "You have initialized an object!"
  # end
 
  # after_find do |post|
  #   puts "You have found an object!"
  # end
  
  #  after_touch do |post|
  #   puts "You have touched an object"
  # end
  # around_save :save_around
  # def save_around
  # 	puts "around_save"
  # end
  # after_destroy :destroy_after
  # def destroy_after
  # 	puts "Article destroyed"
  # end
  # before_save :user1

  # before_create :find_user
  # after_create :user
  # def find_user
  # 	puts "before_save"
  # end
  # def user
  # 	puts "after save"
  # end
  # def user1
  # 	puts "before_save"
  # end


end
