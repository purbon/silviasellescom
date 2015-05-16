module Silviaselles
  class Admin
    module UploadHelper
      def save_files(files)
        saved_files = []
        files.each do |file|
          saved_files << save_file(Padrino.root, file)
        end
        saved_files
      end

      def save_file(basedir, file)
        filename = File.join("public", "images", file[:filename])
        File.open(filename, "wb") do |f|
          f.write(file[:tempfile].read)
        end
        file[:filename]
      end
    end
    helpers UploadHelper
  end
end
