json.extract! recibo, :id, :data, :valor, :valor_extenso, :created_at, :updated_at
json.url recibo_url(recibo, format: :json)
