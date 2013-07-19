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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130719222315) do

  create_table "bodycomps", :force => true do |t|
    t.date     "date"
    t.integer  "client_id"
    t.integer  "age"
    t.integer  "height"
    t.string   "height_units",        :default => "inches"
    t.integer  "weight"
    t.string   "weight_units",        :default => "pounds"
    t.float    "pec"
    t.float    "tri"
    t.float    "subscap"
    t.float    "suprailiac"
    t.float    "midaxil"
    t.float    "umbilical"
    t.float    "calf"
    t.float    "bicep"
    t.float    "low_back"
    t.float    "quad"
    t.string   "sex"
    t.float    "waist"
    t.float    "hip"
    t.float    "neck"
    t.float    "shoulder"
    t.float    "chest"
    t.float    "arm"
    t.float    "thigh"
    t.float    "gastroc"
    t.string   "circumference_units", :default => "inches"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.date     "dob"
    t.integer  "trainer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image"
  end

  create_table "pictures", :force => true do |t|
    t.string   "title"
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "trainers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_trainer"
    t.boolean  "is_client"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "workout_sessions", :force => true do |t|
    t.integer  "workout_id"
    t.integer  "trainer_id"
    t.integer  "client_id"
    t.datetime "date"
    t.boolean  "reminder_sent", :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "workouts", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "trainer_id"
    t.integer  "client_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
