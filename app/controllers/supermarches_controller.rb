class SupermarchesController < ApplicationController
  before_action :set_supermarch, only: %i[ show edit update destroy ]

  # GET /supermarches or /supermarches.json
  def index
    @supermarches = current_user.admin? ? Supermarche.all : current_user.supermarches
    @supermarches = @supermarches.includes(:ville, :liste_de_prix, :liste_de_prix_items)
    @view = params[:view] || "list"
    respond_to do |format|
      format.html
      format.xls { send_data @supermarches.to_xls, filename: "supermarches-#{Date.today}.xls" }
    end
  end

  # GET /supermarches/1 or /supermarches/1.json
  def show
  end

  # GET /supermarches/new
  def new
    @supermarch = Supermarche.new
  end

  # GET /supermarches/1/edit
  def edit
  end

  def import
    if params[:file].present?
      Supermarche.import(params[:file])
      redirect_to supermarches_path, notice: "Supermarchés importés avec succès."
    else
      redirect_to supermarches_path, alert: "Veuillez sélectionner un fichier XLS."
    end
  end

  def suspend
    @supermarche = Supermarche.find(params[:id])
    @supermarche.update(status: "Suspendu")
    redirect_to supermarches_path, notice: "Supermarché suspendu."
  end

  def reactivate
    @supermarche = Supermarche.find(params[:id])
    @supermarche.update(status: "Actif")
    redirect_to supermarches_path, notice: "Supermarché réactivé."
  end

  def archive
    @supermarche = Supermarche.find(params[:id])
    @supermarche.update(status: "Archivé")
    redirect_to supermarches_path, notice: "Supermarché archivé."
  end

  # POST /supermarches or /supermarches.json
  def create
    @supermarch = Supermarche.new(supermarch_params)
    @supermarch.user = current_user
    @supermarch.societe = current_user.societe

    respond_to do |format|
      if @supermarch.save
        format.html { redirect_to @supermarch, notice: "Supermarche was successfully created." }
        format.json { render :show, status: :created, location: @supermarch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supermarch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supermarches/1 or /supermarches/1.json
  def update
    respond_to do |format|
      if @supermarch.update(supermarch_params)
        format.html { redirect_to @supermarch, notice: "Supermarche was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @supermarch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @supermarch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supermarches/1 or /supermarches/1.json
  def destroy
    @supermarch.destroy!

    respond_to do |format|
      format.html { redirect_to supermarches_path, notice: "Supermarche was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supermarch
      @supermarch = current_user.admin? ? Supermarche.find(params[:id]) : current_user.supermarches.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supermarch_params
      permitted = [:name, :logo, :email, :phone, :ville_id, :code, :quartier, :lieu_dit, :latitude, :longitude]
      permitted << :status if current_user.admin?
      params.require(:supermarche).permit(permitted)
    end
end
