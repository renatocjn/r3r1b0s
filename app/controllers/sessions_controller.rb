class SessionsController < ApplicationController
  before_action :authorize, only: [:destroy]

  def new
  end

  def create
    user = Usuario.find_by_email(params[:email])

    if user.nil?
      redirect_to '/login', notice: "Usuário não encontrado"
    elsif user.isBlocked
      redirect_to '/login', notice: "Usuário bloqueado"
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login', notice: "Senha incorreta"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
