Sequel.migration do
  up do
    create_table :photo_comments do
      primary_key :id
      foreign_key :project_photo_id, :project_photos
      String :comment
      String :i18n
    end
  end

  down do
    drop_table :photo_comments
  end
end
