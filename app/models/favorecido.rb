class Favorecido < ActiveRecord::Base
    validates :nome, :presence => {:message => "O Nome da pessoa ou empresa deve ser fornecido"}

    validates :cpf_cnpj,
        :presence => {:message => "O CPF ou CNPJ da empresa deve ser fornecido"},
        :uniqueness => {:message => "CPF/CNPJ já cadastrado"},
        :format => {:with => /([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})/,
                    :message => "Deve seguir o formato: 000.000.000-00 ou 00.000.000/0000-00"}

    has_many :recibos

    def to_s
        nome
    end
end
