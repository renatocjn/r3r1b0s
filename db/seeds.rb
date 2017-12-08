# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
    Usuario.new( :nome => "Admin",
        :email => "admin@casebras.com.br",
        :cpf => "000.000.000-00",
        :password => "case123",
        :password_confirmation => "case123",
        :isAdmin => true).save!

    Usuario.new( :nome => "User",
        :email => "user@casebras.com.br",
        :cpf => "111.111.111-11",
        :password => "case123",
        :password_confirmation => "case123",
        :isAdmin => false).save!

    Favorecido.new(:nome => "Favorecido com nome extremamento muito bastante longo", :rg => "12341234123", :cpf_cnpj => "074.451.885-76").save!
    Empresa.new(:nome => "CASPEB - CENTRO ASSISTENCIAL DOS SERVIDORES PUBLICOS DO BRASIL", :cpf_cnpj => "00.802.246/0001-83").save!
    Empresa.new(:nome => "Empresa sem selo de informações", :cpf_cnpj => "67.643.480/5778-86").save!

    50.times do |i|
        Favorecido.new(:nome => "Favorecido ##{i+1}", :cpf_cnpj => `cpf -g`).save!
    end

    50.times do |i|
        Empresa.new(:nome => "Empresa ##{i+1}", :cpf_cnpj => `cpf -g`).save!
    end

    300.times do |i|
        Recibo.new(:data => rand(10.years).seconds.ago,
            :valor => rand(10000) + 100,
            :valor_extenso => "...",
            :referente => ["pagamento de serviço", "compra de equipamentos"].sample,
            :usuario => Usuario.all.sample,
            :empresa => Empresa.all.sample,
            :favorecido => Favorecido.all.sample).save!
    end
end