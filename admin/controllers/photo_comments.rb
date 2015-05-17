Silviaselles::Admin.controllers :photo_comments do
  get :index do
    @title = "Photo_comments"
    @photo_comments = PhotoComment.all
    render 'photo_comments/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'photo_comment')
    @photo_comment = PhotoComment.new
    render 'photo_comments/new'
  end

  post :create do
    @photo_comment = PhotoComment.new(params[:photo_comment])
    if (@photo_comment.save rescue false)
      @title = pat(:create_title, :model => "photo_comment #{@photo_comment.id}")
      flash[:success] = pat(:create_success, :model => 'PhotoComment')
      params[:save_and_continue] ? redirect(url(:photo_comments, :index)) : redirect(url(:photo_comments, :edit, :id => @photo_comment.id))
    else
      @title = pat(:create_title, :model => 'photo_comment')
      flash.now[:error] = pat(:create_error, :model => 'photo_comment')
      render 'photo_comments/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "photo_comment #{params[:id]}")
    @photo_comment = PhotoComment[params[:id]]
    if @photo_comment
      render 'photo_comments/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'photo_comment', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "photo_comment #{params[:id]}")
    @photo_comment = PhotoComment[params[:id]]
    if @photo_comment
      if @photo_comment.modified! && @photo_comment.update(params[:photo_comment])
        flash[:success] = pat(:update_success, :model => 'Photo_comment', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:photo_comments, :index)) :
          redirect(url(:photo_comments, :edit, :id => @photo_comment.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'photo_comment')
        render 'photo_comments/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'photo_comment', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Photo_comments"
    photo_comment = PhotoComment[params[:id]]
    if photo_comment
      if photo_comment.destroy
        flash[:success] = pat(:delete_success, :model => 'Photo_comment', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'photo_comment')
      end
      redirect url(:photo_comments, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'photo_comment', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Photo_comments"
    unless params[:photo_comment_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'photo_comment')
      redirect(url(:photo_comments, :index))
    end
    ids = params[:photo_comment_ids].split(',').map(&:strip)
    photo_comments = PhotoComment.where(:id => ids)
    
    if photo_comments.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Photo_comments', :ids => "#{ids.to_sentence}")
    end
    redirect url(:photo_comments, :index)
  end
end
