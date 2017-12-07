class FavorecidosController < ApplicationController
  before_action :set_favorecido, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :is_admin

  # GET /favorecidos
  # GET /favorecidos.json
  def index
    @favorecidos = Favorecido.all
  end

  # GET /favorecidos/1
  # GET /favorecidos/1.json
  def show
  end

  # GET /favorecidos/new
  def new
    @favorecido = Favorecido.new
  end

  # GET /favorecidos/1/edit
  def edit
  end

  # POST /favorecidos
  # POST /favorecidos.json
  def create
    @favorecido = Favorecido.new(favorecido_params)

    respond_to do |format|
      if @favorecido.save
        format.html { redirect_to favorecidos_url, notice: 'Favorecido criado com sucesso.' }
        format.json { render :show, status: :created, location: @favorecido }
      else
        format.html { render :new }
        format.json { render json: @favorecido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorecidos/1
  # PATCH/PUT /favorecidos/1.json
  def update
    respond_to do |format|
      if @favorecido.update(favorecido_params)
        format.html { redirect_to favorecidos_url, notice: 'Favorecido atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @favorecido }
      else
        format.html { render :edit }
        format.json { render json: @favorecido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorecidos/1
  # DELETE /favorecidos/1.json
  def destroy
    @favorecido.destroy
    respond_to do |format|
      format.html { redirect_to favorecidos_url, notice: 'Favorecido eliminado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorecido
      @favorecido = Favorecido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorecido_params
      params.require(:favorecido).permit(:nome, :rg, :cpf_cnpj)
    end
end
