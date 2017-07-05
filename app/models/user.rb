class User < ActiveRecord::Base
  has_many :payments
  has_many :videos, through: :payments
  has_many :requests

  has_secure_password
  has_attached_file :profile_photo,
                    styles: { medium: '300x300#', thumb:'100x100#' }, # It will crop the image by putting the # symbol at the end.
                    # specify to store images on S3 AWS. (Tell don't store images on the same server of the application)
                    storage: :s3,
                    url: "s3_domain_url",
                    # parperclip is not going to store the full path of the image in the bucket just the image filename.
                    # Using url s3_domain and the path will automatically generate the full path of the AWS image filename.
                    # The image name is the only thing store in our database.
                    path: "/:class/:attachment/:id_partition/:style/:filename",
                    s3_region: ENV["S3_REGION"],
                    s3_credentials: Proc.new { |a| a.instance.s3_credentials }


  validates_attachment_content_type :profile_photo, content_type: /\Aimage\/.*\Z/
  # validates_attachement_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :name, :username,:email, :age, presence: true
  validates :email, :username, uniqueness: true
  validates :age, numericality: {only_integer: true}
  validates :password, length: { minimum: 6 }, allow_nil: true

  # set_default will only work if the object is new
  after_initialize :set_defaults , unless: :persisted?

  scope :actives,     -> { where(active: true) }
  scope :order_by_id, -> { order(:id) }

  # Get all pending requests from an admin user
  def requests
    if self.admin
      Request.where(req_st_id: 2)
    end
  end

  # Set default values when user gets created for the first time
  def set_defaults
    self.active = "t" if self.active.nil?
  end

  # Returns a Hash with the key value pairs of S3 credentials
  def s3_credentials
    {
      bucket: ENV["S3_BUCKET_NAME"],
      access_key_id: ENV["S3_ACCESS_KEY_ID"],
      secret_access_key: ENV["S3_SECRET_ACCESS_KEY"]
    }
  end
end
