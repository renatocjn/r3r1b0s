class RecibosController < ApplicationController
  before_action :set_recibo, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :is_admin, only: [:destroy]
  before_action :mine_or_admin, except: [:destroy, :index, :new, :create]

  # GET /recibos
  # GET /recibos.json
  def index
    if current_user.isAdmin
      @recibos = Recibo.all.order("created_at DESC")
    else
      @recibos = current_user.recibos.order("created_at DESC")
    end

    if params[:id]
      @recibos = @recibos.find(params[:id])
    else
      if params[:min_data]
        @recibos = @recibos.where("data >= ?", params[:min_data])
      end

      if params[:max_data]
        @recibos = @recibos.where("data <= ?", params[:max_data])
      end

      if params[:ref]
        @recibos = @recibos.where("referente like '%#{params[:ref]}%'")
      end

      if params[:empresa]
        @recibos = @recibos.joins(:empresa).where("empresas.nome like '%#{params[:empresa]}%'")
      end

      if params[:favorecido]
        @recibos = @recibos.joins(:favorecido).where("favorecidos.nome like '%#{params[:favorecido]}%'")
      end

      if params[:usuario]
        @recibos = @recibos.joins(:usuario).where("usuarios.nome like '%#{params[:usuario]}%'")
      end
    end
  end

  # GET /recibos/1
  # GET /recibos/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "recibo_#{@recibo.id}",   # Excluding ".pdf" extension.
               #disposition: "attachment",
               show_as_html: params.key?('debug'),
               #orientation: "Landscape",
               #page_size: "A4",
               encoding: 'utf-8',
               layout: 'recibo_layout',
               template: "recibos/show.pdf.erb",
               locals: {:recibo => @recibo, :empresa => @recibo.empresa}
      end
    end
  end

  # GET /recibos/new
  def new
    @recibo = Recibo.new
  end

  # GET /recibos/1/edit
  def edit
  end

  # POST /recibos
  # POST /recibos.json
  def create
    @recibo = Recibo.new(recibo_params)
    @recibo.usuario = current_user
    respond_to do |format|
      if @recibo.save
        format.html { redirect_to recibos_url, notice: 'Recibo criado com sucesso' }
        format.json { render :show, status: :created, location: @recibo }
      else
        format.html { render :new }
        format.json { render json: @recibo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recibos/1
  # PATCH/PUT /recibos/1.json
  def update
    respond_to do |format|
      if @recibo.update(recibo_params)
        format.html { redirect_to recibos_url, notice: 'Recibo atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @recibo }
      else
        format.html { render :edit }
        format.json { render json: @recibo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recibos/1
  # DELETE /recibos/1.json
  def destroy
    @recibo.destroy
    respond_to do |format|
      format.html { redirect_to recibos_url, notice: 'Recibo eliminado com sucesso' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recibo
      @recibo = Recibo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recibo_params
      params.require(:recibo).permit(:data, :valor, :valor_extenso, :referente, :recibo_assinado, :empresa_id, :favorecido_id, :max_data, :min_date)
    end

    def mine_or_admin
      redirect_to :root, notice: "Acesso negado" unless current_user.isAdmin or @recibo.usuario == current_user
    end
end
