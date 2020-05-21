class Api::LibraryRelationshipsController < ApplicationController
  def show
    # librel自体が欲しいわけではないからshow入らないかも
    # @lib_rel = LibraryRelationship.where(user_id)
  end

  def create
    @lib_rel = LibraryRelationship.new(libRel_params)
    if @lib_rel.save
      # 多分いらない、確認用
      render :show, status: :created
    else
      render json: @lib_rel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /library_relationships/:id
  def destroy
    @lib_rel = LibraryRelationship.find_by(libRel_params)
    # idが必要なのでfind_byは使えない
    # @lib_rel = LibraryRelationship.find_by(params_fetch)
    @lib_rel.destroy
    render json: {status: 205, message: "Reset content"}
  end

  private
  def libRel_params
    params.fetch(:libRel, {}).permit(
        :user_id, :library_id
    )
  end
end
