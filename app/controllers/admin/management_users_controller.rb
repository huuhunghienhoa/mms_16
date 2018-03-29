class Admin::ManagementUsersController < AdminController
  before_action :load_user, except: :load_user_by_team

  def move_to_other_team
    @teams = Team.newest
  end

  def update_to_other_team
    respond_to do |format|
      if (@user.team.id != params[:user][:team_id].to_i) && (@user.update_attribute :team_id, params[:user][:team_id])
        @status = true
      else
        @status = false
      end
      format.js
    end
  end

  def delete_from_team
    respond_to do |format|
      if @user.update_attribute :team_id, nil
        format.js
        format.html{redirect_to admin_teams_path}
      else
        format.html{redirect_to admin_team_path(@user.team)}
      end
    end
  end

  def load_user_by_team
    @users_in_team = User.users_in_team(params[:team_id]).map{|u| {id: u.id, name: u.name}} if params[:team_id]
    @users_in_team = User.all.map{|u| {id: u.id, name: u.name}} if @users_in_team.blank?
    respond_to do |format|
      format.json{render json: {users: @users_in_team}}
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    @user || render(file: "public/404.html", status: 404, layout: true)
  end
end
