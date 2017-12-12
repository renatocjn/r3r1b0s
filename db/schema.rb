# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171212142812) do

  create_table "empresas", force: :cascade do |t|
    t.string   "cpf_cnpj"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "nome"
    t.string   "info_img_id"
    t.string   "info_img_filename"
    t.integer  "info_img_size"
    t.string   "info_img_content_type"
  end

  create_table "favorecidos", force: :cascade do |t|
    t.string   "rg"
    t.string   "cpf_cnpj"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "nome"
  end

  create_table "recibos", force: :cascade do |t|
    t.date     "data"
    t.float    "valor"
    t.string   "valor_extenso"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "usuario_id"
    t.integer  "favorecido_id"
    t.integer  "empresa_id"
    t.string   "referente"
    t.string   "recibo_assinado_id"
    t.string   "recibo_assinado_filename"
    t.integer  "recibo_assinado_size"
    t.string   "recibo_assinado_content_type"
  end

  add_index "recibos", ["empresa_id"], name: "index_recibos_on_empresa_id"
  add_index "recibos", ["favorecido_id"], name: "index_recibos_on_favorecido_id"
  add_index "recibos", ["usuario_id"], name: "index_recibos_on_usuario_id"

  create_table "usuarios", force: :cascade do |t|
    t.string   "nome"
    t.string   "cpf"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "isAdmin"
    t.boolean  "isBlocked"
  end

end
