
class Post < ActiveRecord::Base


  public
  validates_presence_of :name, :title
  before_validation :ensure_title_has_a_value
  validates_format_of :name, :with => /^[A-Z]/, :message => "Start with caps"
  # validates_inclusion_of :name, :in => %w(Janani, Tharshini),
  #     :message => "{{value}} is not a valid name"
  # validates_exclusion_of :name, :in => %w(Somesh, Maadu),
  #       :message => "{{value}} is excluded"
  validates_length_of :title, :minimum => 5, :too_short => "{{count}} characters is the minimum allowed"
  has_many :comments, :dependent => :destroy
  validates_associated :comments
  has_many :tags
  validates_associated :tags,  :on => :create
  validates_acceptance_of :toc, :message => "Must be accepted"
  validate :title_custom

  def title_custom
    errors.add(:title, "trying custom validation - length greater than 6 char") if !title.blank? and title.length > 6
  end
  accepts_nested_attributes_for :tags, :allow_destroy => :true  ,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }



  protected
    def ensure_title_has_a_value
      if title.nil?
        self.title = name unless name.blank?
      end
    end




end
