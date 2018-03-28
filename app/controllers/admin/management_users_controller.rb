class Admin::ManagementUsersController < AdminController
  before_action :load_user

  def move_to_other_team
    @teams = Team.all
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

  private

  def load_user
    @user = User.find_by id: params[:id]
    @user || render(file: "public/404.html", status: 404, layout: true)
  end
end
