class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_owner, only: [:edit]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path, notice: 'プロトタイプが作成されました！'
    else
      render :new
    end
  end

  def show
    # set_prototype で @prototype はすでにセットされているので不要かも
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    # @prototype は set_prototype でセット済み
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: "プロトタイプを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path, notice: "プロトタイプを削除しました"
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def redirect_unless_owner
    unless current_user == @prototype.user
      redirect_to root_path, alert: "編集権限がありません"
    end
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
