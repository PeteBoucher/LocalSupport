class UsersController < ApplicationController
  layout 'full_width'
  # would like this to support generic updating of model with
  # business logic pulled into a separate model or process
  def update
    user = User.find_by_id(params[:id])
    if params[:organization_id]
      user.pending_organization_id = params[:organization_id]
      user.save!
      org = Organization.find(params[:organization_id])
      flash[:notice] = "You have requested admin status for #{org.name}"
      redirect_to(organization_path(params[:organization_id]))
    else
      redirect_to :status => 404 and return unless current_user.admin?
      user.promote_to_org_admin
      flash[:notice] = "You have approved #{user.email}."
      redirect_to(users_path)
    end
  end

  def index
    if !current_user.admin?
      #flash[:notice] = "You must be signed in as an admin to perform this action!"
      redirect_to root_path
      flash[:notice] = "You must be signed in as an admin to perform this action!"
    else
      @users = User.first(2)
    end
  end
end
