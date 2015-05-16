Silviaselles::App.controllers :web do
  layout :app


  before do
    @lang = params["locale"] || I18n.locale
  end

  get :index, :map => "/" do
    render "index"
  end

  get :projects, :map => "/projects" do
    @photos = ProjectPhoto.search
    render "projects"
  end

  get :contactme, :map => "/contactme" do
    render "contactme"
  end


  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  

end
