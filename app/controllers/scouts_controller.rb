class ScoutsController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def new
    @scout.email = current_user.email
  end

  def create
    if @scout.save
      current_user.scout = @scout
      current_user.save
      flash[:notice] = "スカウト登録しました。"
      redirect_to my_scout_url(@scout)
    else
      render "new"
    end
  end
  
  def edit
  end

  def update
    if @scout.update(scout_params)
      flash[:notice] = I18n.t "helpers.notices.updated", model: Scout.model_name.human
      redirect_to scout_path(@scout)
    else
      render "edit"
    end
  end

  def destroy
    @scout.destroy
    flash[:notice] = I18n.t "helpers.notices.destroyed", model: Scout.model_name.human
    redirect_to my_top_url
  end

  private
    def scout_params
      params.require(:scout).permit([:company, :last_name, :first_name,
                                     :zip, :prefecture, :city, :address,
                                     :building, :email, :phone])
    end
end
