class Recibo < ActiveRecord::Base
    belongs_to :usuario
    belongs_to :favorecido
    belongs_to :empresa

    validates :data, :presence => {:message => "Informe a data deste recibo"}

    validates :valor,
        :presence => {:message => "Informe o valor deste recibo"},
        :numericality => {:greater_then => 0, :message => "O valor do recibo deve ser positivo"}

    validates :valor_extenso, :presence => {:message => "Informe o valor por extenso deste recibo"}

    validates :usuario, :presence => true
    validates :favorecido, :presence => {:message => "Favor informe o favorecido por este recibo"}
    validates :empresa, :presence => {:message => "Favor informe a empresa responsável por este recibo"}

    attachment :recibo_assinado, content_type: ["image/jpeg", "image/png", "image/gif", "application/pdf"]

    def recibo_assinado_ja_enviado
      recibo_assinado.nil?
    end

    def to_s
        "Recibo Nº #{id}"
    end
end
