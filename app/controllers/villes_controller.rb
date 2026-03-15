class VillesController < ApplicationController
  before_action :set_ville, only: %i[ show edit update destroy ]

  # GET /villes or /villes.json
  def index
    @villes = Ville.all
    @view = params[:view] || "list"
  end

  # GET /villes/1 or /villes/1.json
  def show
  end

  # GET /villes/new
  def new
    @ville = Ville.new
  end

  # GET /villes/1/edit
  def edit
  end

  # POST /villes or /villes.json
  def create
    @ville = Ville.new(ville_params)

    respond_to do |format|
      if @ville.save
        format.html { redirect_to @ville, notice: "Ville was successfully created." }
        format.json { render :show, status: :created, location: @ville }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ville.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /villes/1 or /villes/1.json
  def update
    respond_to do |format|
      if @ville.update(ville_params)
        format.html { redirect_to @ville, notice: "Ville was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @ville }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ville.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /villes/1 or /villes/1.json
  def destroy
    @ville.destroy!

    respond_to do |format|
      format.html { redirect_to villes_path, notice: "Ville was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ville
      @ville = Ville.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ville_params
      params.require(:ville).permit(:name, :code, :status)
    end
end
