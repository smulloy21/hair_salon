class Client
  attr_reader(:id, :name, :phone, :stylist_id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id, nil)
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone, nil)
    @stylist_id = attributes.fetch(:stylist_id, nil)
  end
  define_singleton_method(:all) do
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients;")
    returned_clients.each() do |client|
      id = client.fetch('id').to_i()
      name = client.fetch('name')
      phone = client.fetch('phone').to_i()
      stylist_id = client.fetch('stylist_id').to_i()
      clients.push(Client.new({:id => id, :name => name, :phone => phone, :stylist_id => stylist_id}))
    end
    clients
  end
end
