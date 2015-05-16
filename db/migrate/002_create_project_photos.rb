Sequel.migration do
  up do
    create_table :project_photos do
      primary_key :id
      String :title
      String :alt
      String :location
      Boolean :frontpage
    end
  end

  down do
    drop_table :project_photos
  end
end
