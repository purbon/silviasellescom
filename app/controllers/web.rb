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

  post :contactme, :map => "/contactme" do
    subject =  "contact me from #{params[:from]} at silviaselles.com"
    email(:from => params[:email], :to => settings.contactme, :subject => subject, :body=>params[:message])
    redirect(url(:web, :contactme))
  end

end
