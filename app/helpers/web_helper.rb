# Helper methods defined here can be accessed in any controller or view in the application

module Silviaselles
  class App
    module WebHelper
      def link_with_locale(*args, &block)
        if I18n.locale
          args[1] << "?locale=#{I18n.locale}"
        end
        link_to(*args, &block)
      end
    end
    helpers WebHelper
  end
end
