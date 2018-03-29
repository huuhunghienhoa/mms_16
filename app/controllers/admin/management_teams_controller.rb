class Admin::ManagementTeamsController < AdminController
  before_action :load_team

  def add_member
    @users = User.newest
  end

  def update_member_team
    if @team.update_attributes team_params
      flash[:success] = t "admin.teams.team.update_success"
    else
      flash[:danger] = t "admin.teams.team.update_fail"
    end
    redirect_to admin_team_path @team
  end

  def empty_member_team
    respond_to do |format|
      if @team.update_attributes user_ids: nil
        format.js
      else
        flash[:danger] = t "admin.teams.team.empty_team_fail"
        format.html{redirect_to admin_team_path @team}
      end
    end
  end

  private

  def team_params
    params.require(:team).permit user_ids: []
  end

  def load_team
    @team = Team.find_by id: params[:id]
    @team || render(file: "public/404.html", status: 404, layout: true)
  end
end
