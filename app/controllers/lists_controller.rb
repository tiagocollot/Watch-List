class ListsController < ApplicationController
  # before_action :find_list, except: :destroy
  # def index
  #   @lists = List.all
  # end

  # def show
  #   @list = List.find(params[:id])
  # end

  # def new
  #   @list = List.new
  # end

  # def create
  #   @list = List.new(list_params)
  #   @list.save
  # end

  #  private

  # def list_params
  #   params.require(:list).permit(:name)
  # end

  # def find_list
  #   @list = list.find(params[:id])
  # end
# end
  before_action :set_list, only: %i[show destroy]
  def index
    @lists = List.all
  end
  def new
    @list = List.new
  end

  def show
    @bookmark = Bookmark.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list, notice: 'List was successfully created.'
    else
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list = List.find(params[:id])
  end
  # Only allow a list of trusted parameters through.
  def list_params
    params.require(:list).permit(:name)
  end
end
