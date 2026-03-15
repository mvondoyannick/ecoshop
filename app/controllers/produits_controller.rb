class ProduitsController < ApplicationController
  before_action :set_produit, only: %i[ show edit update destroy ]

  # GET /produits or /produits.json
  def index
    @produits = current_user.admin? ? Produit.all : current_user.produits
  end

  # GET /produits/1 or /produits/1.json
  def show
  end

  # GET /produits/new
  def new
    @produit = Produit.new
  end

  # GET /produits/1/edit
  def edit
  end

  # POST /produits or /produits.json
  def create
    @produit = Produit.new(produit_params)
    @produit.user = current_user
    @produit.societe = current_user.societe

    respond_to do |format|
      if @produit.save
        format.html { redirect_to @produit, notice: "Produit was successfully created." }
        format.json { render json: { id: @produit.id, name: @produit.name }, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @produit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produits/1 or /produits/1.json
  def update
    respond_to do |format|
      if @produit.update(produit_params)
        format.html { redirect_to @produit, notice: "Produit was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @produit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @produit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produits/1 or /produits/1.json
  def destroy
    @produit.destroy!

    respond_to do |format|
      format.html { redirect_to produits_path, notice: "Produit was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produit
      @produit = current_user.admin? ? Produit.find(params[:id]) : current_user.produits.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def produit_params
      params.require(:produit).permit(:name, :category, :udm, :udm_value, :image, :sku, :promotion, :promotion_start_date, :promotion_end_date, :promotion_price, :bulk_sale_quantity, :bulk_sale_discount_percentage)
    end
end
