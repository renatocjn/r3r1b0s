class EmpresasController < ApplicationController
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :is_admin, except: [:show]

  # GET /empresas
  # GET /empresas.json
  def index
    if params.key? :empresa
      if params[:empresa].key? :nome
        @empresas = Empresa.where("lower(nome) like '%#{params[:empresa][:nome].strip.downcase}%'").order(created_at: :desc).page(params[:page])
      elsif params[:empresa].key? :cpf_cnpj
        @empresas = Empresa.where("cpf_cnpj like '%#{params[:empresa][:cpf_cnpj].strip}%'").order(created_at: :desc).page(params[:page])
      end
    else
      @empresas = Empresa.all.order(created_at: :desc).page(params[:page])
    end
  end

  # GET /empresas/1
  # GET /empresas/1.json
  def show
  end

  # GET /empresas/new
  def new
    @empresa = Empresa.new
  end

  # GET /empresas/1/edit
  def edit
  end

  # POST /empresas
  # POST /empresas.json
  def create
    @empresa = Empresa.new(empresa_params)
    respond_to do |format|
      if @empresa.save
        format.html { redirect_to empresas_url, notice: 'Empresa registrada com sucesso.' }
        format.json { render :show, status: :created, location: @empresa }
      else
        format.html { render :new }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empresas/1
  # PATCH/PUT /empresas/1.json
  def update
    respond_to do |format|
      if @empresa.update(empresa_params)
        format.html { redirect_to empresas_url, notice: 'Empresa atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @empresa }
      else
        format.html { render :edit }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empresas/1
  # DELETE /empresas/1.json
  def destroy
    @empresa.destroy
    respond_to do |format|
      format.html { redirect_to empresas_url, notice: 'Empresa elimida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empresa
      @empresa = Empresa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empresa_params
      params.require(:empresa).permit(:nome, :cpf_cnpj, :info_img)
    end
end
