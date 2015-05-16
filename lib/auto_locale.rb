##
# This extension give to padrino the ability to change
# their locale inspecting.
# 
# ==== Usage
# 
#   class MyApp < Padrino::Application
#     register AutoLocale
#     set :locales, [:en, :ru, :de] # First locale is the default locale
#   end
# 
# So when we call an url like: /ru/blog/posts this extension set for you :ru as I18n.locale
# 
module AutoLocale
  module Helpers
    ##
    # This reload the page changing the I18n.locale
    #
    def switch_to_lang(lang)
      request.path_info.sub(/\/#{I18n.locale}/, "/#{lang}") if options.locales.include?(lang)
    end

  end # Helpers

  def self.registered(app)
    app.helpers AutoLocale::Helpers
    app.set :locales, [:en]
    app.before do
      if request.fullpath =~ /locale=(#{options.locales.join('|')})&?/
        I18n.locale = $1.to_sym
      else
        I18n.locale = options.locales.first
      end
    end
  end # self.registered
end # AutoLocale
