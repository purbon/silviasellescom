class ProjectPhoto < Sequel::Model
  def self.search(options={})
    options.merge!(:frontpage => true) unless options[:frontpage]
    ProjectPhoto.where(options).all
  end
end
