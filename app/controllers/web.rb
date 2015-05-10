Silviaselles::App.controllers :web do
  layout :app

  get :index, :map => "/" do
    render "index"
  end

  get :projects, :map => "/projects" do
    render "projects"
  end

  get :about, :map => "/about" do
    render "about"
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
