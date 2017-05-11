class ProfilesController < ApplicationController

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile successfully updated"
      redirect_to user_profile_path
    else
      flash.now[:error] = "You done fucked up pal."
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:firstname, :lastname, :date_of_birth, :gender, :website, :github_profile, :phone_number, :address_line_one, :address_line_two, :city, :country, :post_code, :odin_profile_link)
  end
end
