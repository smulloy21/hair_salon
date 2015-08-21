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
      phone = client.fetch('phone')
      stylist_id = client.fetch('stylist_id').to_i()
      clients.push(Client.new({:id => id, :name => name, :phone => phone, :stylist_id => stylist_id}))
    end
    clients
  end

  define_method(:==) do |other|
    self.id() == other.id()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, phone) VALUES ('#{@name}', '#{@phone}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:find) do |id|
    Client.all().each() do |client|
      if client.id() == id
        return client
      end
    end
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @phone = attributes.fetch(:phone, @phone)
    DB.exec("UPDATE clients SET name = '#{@name}', phone = '#{@phone}' WHERE id = #{self.id()};")
    if attributes.include?(:stylist_id)
      @stylist_id = attributes.fetch(:stylist_id)
      DB.exec("UPDATE clients SET stylist_id = #{stylist_id} WHERE id = #{self.id()};")
    end
  end

  define_method(:remove_stylist) do
    @stylist_id = nil
    DB.exec("UPDATE clients SET stylist_id = NULL WHERE id = #{self.id()};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end

end
