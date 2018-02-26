class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :is_admin, except: [:show, :edit, :update]
  before_action :me_or_admin, only: [:show, :edit, :update]

  # GET /usuarios
  # GET /usuarios.json
  def index
    if params.key? :usuario
      if params[:usuario].key? :nome
        @usuarios = Usuario.where("lower(nome) like '%#{params[:usuario][:nome].strip.downcase}%'").order(created_at: :desc).page(params[:page])
      elsif params[:usuario].key? :cpf
        @usuarios = Usuario.where("cpf like '%#{params[:usuario][:cpf].strip}%'").order(created_at: :desc).page(params[:page])
      elsif params[:usuario].key? :email
        @usuarios = Usuario.where("lower(email) like '%#{params[:usuario][:email].strip.downcase}%'").order(created_at: :desc).page(params[:page])
      end
    else
      @usuarios = Usuario.all.order(created_at: :desc).page(params[:page])
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
    @ultimos_recibos = @usuario.recibos.order(data: :desc)
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(usuario_params)
    respond_to do |format|
      if @usuario.save
        format.html { redirect_to usuarios_url, notice: 'Usuário criado com sucesso.' }
        format.json { render :show, status: :created, location: @usuario }
      else
        format.html { render :new }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
    @usuario.isAdmin = false unless current_user.isAdmin #bloqueio de atualização de permissão para usuarios que não são admin
    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to (current_user.isAdmin ? usuarios_url : recibos_url), notice: 'Usuário atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: 'Usuário eliminado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_params
      params.require(:usuario).permit(:nome, :cpf, :email, :password, :password_confirmation, :isAdmin, :isBlocked, :updating_password)
    end

    def me_or_admin
      redirect_to :root, notice: "Acesso negado" unless current_user.isAdmin or current_user == @usuario
    end
end
