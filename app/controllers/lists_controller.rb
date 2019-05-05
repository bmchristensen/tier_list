class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def index
    @lists = List.all
  end

  def create
    @workflow = CreatesList.new(
      name: params[:list][:name],
      champ_string: params[:list][:champions])
    @workflow.create
    if @workflow.success?
      redirect_to lists_path
    else
      @list = @workflow.list
      render :new
    end
  end

  def show
    @list = List.find(params[:id])
  end
end
