class ProjectPhoto < Sequel::Model
  one_to_many :photo_comments

  def self.search(options={})
    options.merge!(:frontpage => true) unless options[:frontpage]
    ProjectPhoto.where(options).all
  end
end
