class Admin::ProjectsController < ApplicationController
  before_action :load_project, except: %i(index new create)
  before_action :load_projects_filter, only: :index
  before_action :load_users, only: %i(new create)
  before_action :load_teams, except: %i(show destroy)

  def index
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show; end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    if @project.save
      flash[:success] = t "admin.projects.project.create_success"
      redirect_to admin_project_path @project
    else
      flash.now[:danger] = t "admin.projects.project.create_fail"
      render :new
    end
  end

  def edit
    @users = @project.team.users
  end

  def update
    @users = @project.team.users
    if @project.update_attributes project_params
      flash[:success] = t "admin.projects.project.update_success"
      redirect_to admin_project_path @project
    else
      flash[:danger] = t "admin.projects.project.update_fail"
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = t "admin.projects.project.delete_success"
    else
      flash[:danger] = t "admin.projects.project.delete_fail"
    end
    redirect_to admin_projects_path
  end

  private

  def project_params
    params.require(:project).permit :name, :team_id, :date_start, :date_end, :leader_id, user_ids: []
  end

  def load_project
    @project = Project.find_by id: params[:id]
    @project || render(file: "public/404.html", status: 404, layout: true)
  end

  def load_projects_filter
    if params[:project] && params[:project][:filter].present?
      @projects = Project.search params[:project][:filter]
    else
      @projects = Project.newest.paginate page: params[:page], per_page: Settings.paginate.per_page
    end
  end

  def load_users
    @users = User.newest
  end

  def load_teams
    @teams = Team.newest
  end
end
