require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/client')
require('./lib/stylist')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:index)
end

post('/new_stylist') do
  name = params.fetch('name')
  stylist = Stylist.new({:name => name})
  stylist.save()
  redirect('/')
end

post('/new_client') do
  name = params.fetch('name')
  phone = params.fetch('phone')
  client = Client.new({:name => name, :phone => phone, :stylist_id => nil})
  client.save
  redirect('/')
end

get('/stylist/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i())
  erb(:stylist)
end

patch('/stylist/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i())
  name = params.fetch('name')
  @stylist.update({:name => name})
  redirect('/stylist/' + @stylist.id().to_s())
end

delete('/stylist/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i())
  @stylist.delete()
  redirect('/')
end

get('/client/:id') do
  @client = Client.find(params.fetch('id').to_i())
  @stylists = Stylist.all()
  erb(:client)
end

patch('/client/:id') do
  @client = Client.find(params.fetch('id').to_i())
  name = params.fetch('name')
  phone = params.fetch('phone')
  @client.update({:name => name}) if name != ""
  @client.update({:phone => phone}) if phone != ""
  redirect('/client/' + @client.id().to_s())
end

delete('/client/:id') do
  @client = Client.find(params.fetch('id').to_i())
  @client.delete()
  redirect('/')
end

patch('/client/:id/add_stylist') do
  @client = Client.find(params.fetch('id').to_i())
  id = params.fetch('stylist_id').to_i()
  @client.update({:stylist_id => id})
  redirect('/client/' + @client.id().to_s())
end

patch('/client/:id/remove_stylist') do
  @client = Client.find(params.fetch('id').to_i())
  @client.remove_stylist()
  redirect('/client/' + @client.id().to_s())
end
