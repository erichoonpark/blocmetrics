class AppsController < ApplicationController
  def create
    @app = App.new(params.require(:app).permit(:title, :url))
    @app.user_id = 1
    if @app.save
      flash[:notice] = "App was saved!"
      redirect_to @app
    else
      flash[:error] = "There an error, oh noes!Please try again!"
      render :new
    end
  end

  def new
    @app = App.new
  end

  def show
    @app = App.find(params[:id])
  end

  def index
    @apps = App.all
  end

  def edit
    @app = App.find(params[:id])
  end

  def update
    @app = App.find(params[:id])
     if @app.update_attributes(params.require(:app).permit(:title, :url))
       flash[:notice] = "Application was updated."
       redirect_to @app
     else
       flash[:error] = "There was an error saving the app. Please try again."
       render :edit
     end
  end

  def destroy
    @app = App.find(params[:id])
    if @app.destroy
      flash[:notice] = "App was removed."
    else
      flash[:error] = "App couldn't be deleted. Try again."
    end

     respond_to do |format|
       format.html
       format.js
     end
  end
end
