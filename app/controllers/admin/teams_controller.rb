class Admin::TeamsController < AdminController
  before_action :load_team, except: %i(index new create)

  def index
    @teams = Team.newest.paginate page: params[:page], per_page: Settings.paginate.per_page
  end

  def show
    @users = @team.users.newest.paginate page: params[:page], per_page: Settings.paginate.per_page
  end

  def new
    @team = Team.new
    @users = User.all
  end

  def create
    @team = Team.new team_params
    @users = User.all
    if @team.save
      flash[:success] = t "admin.teams.team.create_success"
      redirect_to admin_teams_path
    else
      flash.now[:danger] = t "admin.teams.team.create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @team.update team_params
      flash[:success] = t "admin.teams.team.update_success"
      redirect_to admin_teams_path
    else
      render :edit
    end
  end

  def destroy
    if @team.users.any?
      flash[:danger] = t "admin.teams.team.not_allowed"
    else
      if @team.destroy
        flash[:success] = t "admin.teams.team.delete_success"
      else
        flash[:fail] = t "admin.teams.team.delete_fail"
      end
    end
    redirect_to admin_teams_path
  end

  private

  def team_params
    params.require(:team).permit :name, :description, :leader_id, :logo
  end

  def load_team
    @team = Team.find_by id: params[:id]
    @team || render(file: "public/404.html", status: 404, layout: true)
  end
end
