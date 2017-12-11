class RecibosController < ApplicationController
  before_action :set_recibo, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :is_admin, only: [:destroy]
  before_action :mine_or_admin, except: [:destroy, :index, :new, :create]

  # GET /recibos
  # GET /recibos.json
  def index
    if current_user.isAdmin
      @recibos = Recibo.all
    else
      @recibos = current_user.recibos
    end

    if params.key? :recibo
      if params[:recibo].key? :id
        @recibos = @recibos.where("id = #{params[:recibo][:id].strip}")
      else
        if params[:recibo].key? :min_data and params[:recibo].key? :max_data
          params[:recibo][:min_data] = (Date.today - 30.years).to_s if params[:recibo][:min_data].blank?
          params[:recibo][:max_data] = (Date.today + 30.years).to_s if params[:recibo][:max_data].blank?
          @recibos = @recibos.where("data >= ? and data <=?", Date.parse(params[:recibo][:min_data]), Date.parse(params[:recibo][:max_data]))
        end

        if params[:recibo].key? :referente
          @recibos = @recibos.where("referente like '%#{params[:recibo][:referente].strip}%'")
        end

        if params[:recibo].key? :empresa
          @recibos = @recibos.joins(:empresa).where("empresas.nome like '%#{params[:recibo][:empresa].strip}%'")
        end

        if params[:recibo].key? :favorecido
          @recibos = @recibos.joins(:favorecido).where("favorecidos.nome like '%#{params[:recibo][:favorecido].strip}%'")
        end

        if params[:recibo].key? :usuario
          @recibos = @recibos.joins(:usuario).where("usuarios.nome like '%#{params[:recibo][:usuario].strip}%'")
        end
      end
    end
    @recibos = @recibos.includes(:empresa, :favorecido, :usuario).order(created_at: :desc).page(params[:page])
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
    @recibo = Recibo.new(:data => Date.today)
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
      params.require(:recibo).permit(:data, :valor, :valor_extenso, :referente, :recibo_assinado, :empresa_id, :favorecido_id, :max_date, :min_date)
    end

    def mine_or_admin
      redirect_to :root, notice: "Acesso negado" unless current_user.isAdmin or @recibo.usuario == current_user
    end
end
