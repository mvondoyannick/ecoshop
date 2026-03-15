class ListeDePrixesController < ApplicationController
  before_action :set_liste_de_prix, only: %i[ show edit update destroy activate ]

  def activate
    @liste_de_prix.activate!
    redirect_back fallback_location: liste_de_prixes_path, notice: "La liste de prix a été activée."
  end

  # GET /liste_de_prixes or /liste_de_prixes.json
  def index
    @liste_de_prixes = current_user.admin? ? ListeDePrix.all : current_user.liste_de_prixes
    @liste_de_prixes = @liste_de_prixes.includes(supermarche: { logo_attachment: :blob })
  end

  # GET /liste_de_prixes/1 or /liste_de_prixes/1.json
  def show
  end

  # GET /liste_de_prixes/new
  def new
    @liste_de_prix = ListeDePrix.new
  end

  # GET /liste_de_prixes/1/edit
  def edit
  end

  # POST /liste_de_prixes or /liste_de_prixes.json
  def create
    @liste_de_prix = ListeDePrix.new(liste_de_prix_params)
    @liste_de_prix.user = current_user
    @liste_de_prix.societe = current_user.societe

    respond_to do |format|
      if @liste_de_prix.save
        format.html { redirect_to @liste_de_prix, notice: "Liste de prix was successfully created." }
        format.json { render :show, status: :created, location: @liste_de_prix }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @liste_de_prix.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /liste_de_prixes/1 or /liste_de_prixes/1.json
  def update
    respond_to do |format|
      if @liste_de_prix.update(liste_de_prix_params)
        format.html { redirect_to @liste_de_prix, notice: "Liste de prix was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @liste_de_prix }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @liste_de_prix.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /liste_de_prixes/1 or /liste_de_prixes/1.json
  def destroy
    @liste_de_prix.destroy!

    respond_to do |format|
      format.html { redirect_to liste_de_prixes_path, notice: "Liste de prix was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_liste_de_prix
      @liste_de_prix = current_user.admin? ? ListeDePrix.find(params[:id]) : current_user.liste_de_prixes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def liste_de_prix_params
      params.require(:liste_de_prix).permit(:supermarche_id, liste_de_prix_items_attributes: [:id, :produit_id, :price, :start_date, :end_date, :discount, :discount_type, :discount_quantity, :expiration_date, :_destroy])
    end
end
