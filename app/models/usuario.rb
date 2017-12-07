class Usuario < ActiveRecord::Base

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
        :format => {:with => /[a-zA-Z]+/, :message => "Sua senha deve conter letras e números"}
    validates :password, :format => {:with => /[0-9]+/, :message => "Sua senha deve conter letras e números"}

    validates :isAdmin, :exclusion => {:in => [true, "t", 1, "1", "true", "True"], :message => "Só pode ser atualizado por usuários administradores"}, :unless => :isAdmin

    has_secure_password
    has_many :recibos

    def to_s
        nome
    end
end
