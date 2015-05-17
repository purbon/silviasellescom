class ProjectPhoto < Sequel::Model
  one_to_many :photo_comments

  def self.search(options={})
    options.merge!(:frontpage => true) unless options[:frontpage]
    options.merge!(:i18n => I18n.locale.to_s)
    ProjectPhoto.join_table(:inner, :photo_comments, :project_photo_id => :id).where(options).all
  end

  def self.list
    ProjectPhoto.all.map { |p| {:id => p.id, :title => p.title } }
  end

end
