require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"
require 'pry'

require_relative 'models/contact'


  contact_attributes = [
    { first_name: 'Eric', last_name: 'Kelly', phone_number: '1234567890' },
    { first_name: 'Adam', last_name: 'Sheehan', phone_number: '1234567890' },
    { first_name: 'Dan', last_name: 'Pickett', phone_number: '1234567890' },
    { first_name: 'Evan', last_name: 'Charles', phone_number: '1234567890' },
    { first_name: 'Faizaan', last_name: 'Shamsi', phone_number: '1234567890' },
    { first_name: 'Helen', last_name: 'Hood', phone_number: '1234567890' },
    { first_name: 'Corinne', last_name: 'Babel', phone_number: '1234567890' }
  ]

  @contacts = contact_attributes.map do |attr|
    Contact.new(attr)
  end

get '/' do

  @contacts = Contact.all
  search = params[:query]
  match = "%#{search}%"

    if search
      @contacts = Contact.where("first_name ILIKE :match OR last_name ILIKE :match", match: match)
    end

  erb :index
end

get '/contacts/:id' do
  contact_id = params[:id]
  @contact = Contact.find(contact_id)
  erb :show
end

post '/register' do

  @contacts = Contact.all
  searched_first = params[:first_name]
  search_last = params[:last_name]
  phone_number = params[:phone_number]

  @contacts = Contact.find_or_create_by(first_name: searched_first, last_name: search_last, phone_number: phone_number)
  redirect '/'
end

get '/register' do
  erb :register
end


