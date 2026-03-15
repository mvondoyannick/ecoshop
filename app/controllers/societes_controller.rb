class SocietesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_societe, only: %i[ show edit update destroy ]

  private

  def check_admin
    redirect_to root_path, alert: "Accès refusé." unless current_user.admin?
  end

  # GET /societes or /societes.json
  def index
    @societes = Societe.all
  end

  # GET /societes/1 or /societes/1.json
  def show
  end

  # GET /societes/new
  def new
    @societe = Societe.new
  end

  # GET /societes/1/edit
  def edit
  end

  # POST /societes or /societes.json
  def create
    @societe = Societe.new(societe_params)

    respond_to do |format|
      if @societe.save
        format.html { redirect_to @societe, notice: "Societe was successfully created." }
        format.json { render :show, status: :created, location: @societe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @societe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /societes/1 or /societes/1.json
  def update
    respond_to do |format|
      if @societe.update(societe_params)
        format.html { redirect_to @societe, notice: "Societe was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @societe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @societe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /societes/1 or /societes/1.json
  def destroy
    @societe.destroy!

    respond_to do |format|
      format.html { redirect_to societes_path, notice: "Societe was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_societe
      @societe = Societe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def societe_params
      params.require(:societe).permit(:name, :phone, :ville_id, :logo, :email)
    end
end
