Silviaselles::Admin.controllers :project_photos do
  get :index do
    @title = "Project Photos"
    @project_photos = ProjectPhoto.all
    render 'project_photos/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'project_photo')
    @project_photo = ProjectPhoto.new
    render 'project_photos/new'
  end

  post :create do
    @project_photo = ProjectPhoto.new(params[:project_photo])
    if (@project_photo.save rescue false)
      @title = pat(:create_title, :model => "project_photo #{@project_photo.id}")
      flash[:success] = pat(:create_success, :model => 'ProjectPhoto')
      params[:save_and_continue] ? redirect(url(:project_photos, :index)) : redirect(url(:project_photos, :edit, :id => @project_photo.id))
    else
      @title = pat(:create_title, :model => 'project_photo')
      flash.now[:error] = pat(:create_error, :model => 'project_photo')
      render 'project_photos/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "project_photo #{params[:id]}")
    @project_photo = ProjectPhoto[params[:id]]
    if @project_photo
      render 'project_photos/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'project_photo', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "project_photo #{params[:id]}")
    @project_photo = ProjectPhoto[params[:id]]
    if @project_photo
      if @project_photo.modified! && @project_photo.update(params[:project_photo])
        flash[:success] = pat(:update_success, :model => 'Project_photo', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:project_photos, :index)) :
          redirect(url(:project_photos, :edit, :id => @project_photo.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'project_photo')
        render 'project_photos/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'project_photo', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Project_photos"
    project_photo = ProjectPhoto[params[:id]]
    if project_photo
      if project_photo.destroy
        flash[:success] = pat(:delete_success, :model => 'Project_photo', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'project_photo')
      end
      redirect url(:project_photos, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'project_photo', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Project_photos"
    unless params[:project_photo_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'project_photo')
      redirect(url(:project_photos, :index))
    end
    ids = params[:project_photo_ids].split(',').map(&:strip)
    project_photos = ProjectPhoto.where(:id => ids)
    
    if project_photos.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Project_photos', :ids => "#{ids.to_sentence}")
    end
    redirect url(:project_photos, :index)
  end
end
