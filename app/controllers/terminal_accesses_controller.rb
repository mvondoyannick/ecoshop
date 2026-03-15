class TerminalAccessesController < ApplicationController
  before_action :ensure_admin
  before_action :set_terminal_access, only: %i[ show destroy toggle_block ]

  # GET /terminal_accesses or /terminal_accesses.json
  def index
    @terminal_accesses = TerminalAccess.all.order(created_at: :desc).limit(500)
    @requests_by_day = TerminalAccess.where('created_at > ?', 7.days.ago)
                                     .group("DATE(created_at)")
                                     .order("DATE(created_at) DESC")
                                     .count
  end

  # GET /terminal_accesses/stats?ip=...
  def stats
    ip = params[:ip]
    count = TerminalAccess.where(ip_address: ip).count
    
    render json: {
      ip: ip,
      count: count
    }
  end

  # GET /terminal_accesses/1 or /terminal_accesses/1.json
  def show
  end

  def toggle_block
    # Block/Unblock ALL entries with this IP
    new_status = !@terminal_access.blocked
    TerminalAccess.where(ip_address: @terminal_access.ip_address)
                  .update_all(blocked: new_status)
    
    redirect_back fallback_location: terminal_accesses_path, 
                  notice: "L'accès pour l'IP #{@terminal_access.ip_address} a été #{new_status ? 'bloqué' : 'débloqué'}."
  end

  # DELETE /terminal_accesses/1 or /terminal_accesses/1.json
  def destroy
    @terminal_access.destroy!

    respond_to do |format|
      format.html { redirect_to terminal_accesses_path, notice: "Terminal access was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_terminal_access
      @terminal_access = TerminalAccess.find(params[:id])
    end

    def ensure_admin
      unless current_user&.admin?
        redirect_to root_path, alert: "Accès réservé aux administrateurs."
      end
    end

    # Only allow a list of trusted parameters through.
    def terminal_access_params
      params.require(:terminal_access).permit(:ip_address, :country, :url, :user_agent, :blocked)
    end
end
