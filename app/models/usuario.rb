class Usuario < ActiveRecord::Base
    attr_accessor :updating_password

    after_initialize do
        self.updating_password ||= false
    end

    validates :nome, :presence => {:message => "Por favor, forneça o nome do usuário"}

    validates :email,
        :uniqueness => {:message => "Já existe um usuário com este e-mail"},
        :presence => {:message => "Por favor, forneça o nome completo do usuário"},
        :format => {:with => /\S+@\S+\.\S+/, :message => "O e-mail fornecido inválido"}

    validates :cpf,
        :presence => {:message => "O CPF do usuário deve ser fornecido"},
        :format => {:with => /([0-9]){3}\.([0-9]){3}\.([0-9]){3}-([0-9]){2}/, :message => "Deve seguir o formato: 000.000.000-00"}

    validates :password,
        :length => {:minimum => 6, :message => "Sua senha deve conter pelo menos 6 caracteres"},
        :format => {:with => /[a-zA-Z]+/, :message => "Sua senha deve conter letras e números"}, if: :should_update_password

    validates :password, :format => {:with => /[0-9]+/, :message => "Sua senha deve conter letras e números"}, if: :should_update_password

    # Fazer esta validação no controlador
    #trueValues = [true, "t", 1, "1", "true", "True", "Sim", "Yes", "S", "Y"]
    #validates :isAdmin, :exclusion => {:in => trueValues, :message => "Só pode ser atualizado por usuários administradores"}, :unless => :is_admin
    #validates :isBlocked, :exclusion => {:in => trueValues, :message => "Só pode ser atualizado por usuários administradores"}, :unless => :is_admin

    has_secure_password
    has_many :recibos, dependent: :destroy

    def to_s
        nome
    end

    def should_update_password
        new_record? or updating_password == "true"
    end
end
