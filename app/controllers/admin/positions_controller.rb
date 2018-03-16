class Admin::PositionsController < AdminController
  before_action :load_position, except: %i(index new create)

  def index
    @positions = Position.paginate page: params[:page]
  end

  def show; end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new position_params
    if @position.save
      flash[:success] = t "admin.positions.position.create_success"
      redirect_to admin_position_path @position
    else
      render :new
    end
  end

  def edit; end

  def update
    if @position.update position_params
      flash[:success] = t "admin.positions.position.update_success"
      redirect_to admin_position_path @position
    else
      render :edit
    end
  end

  def destroy
    if @position.destroy
      flash[:success] = t "admin.positions.position.delete_success"
    else
      flash[:fail] = t "admin.positions.position.delete_fail"
    end
    redirect_to admin_positions_path
  end

  private

  def position_params
    params.require(:position).permit :name, :short_name
  end

  def load_position
    @position = Position.find_by id: params[:id]
    @position || render(file: "public/404.html", status: 404, layout: true)
  end
end
