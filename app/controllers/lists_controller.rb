class ListsController < ApplicationController
  def new
    #viewへ渡しためのインスタンス変数に空のModelオブジェクトを生成する
    @list = List.new
  end

  def create
    #1.&2. データを受け取り新規投稿するためのインスタンス作成
    @list = List.new(list_params)
    if @list.save
      flash[:notice] = "投稿が成功しました"
      redirect_to list_path(@list.id)
    else
      render :new
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy
    list = List.find(params[:id]) #データ(レコード)を1件取得
    list.destroy #データ（レコード）を削除
    redirect_to '/lists' #投稿一覧画面へリダイレクト
  end

  private
  #ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
