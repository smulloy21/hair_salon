class Stylist

  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id, nil)
    @name = attributes.fetch(:name)
  end

  define_singleton_method(:all) do
    stylists = []
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    returned_stylists.each() do |stylist|
      name = stylist.fetch('name')
      id = stylist.fetch('id').to_i()
      stylists.push(Stylist.new({:id => id, :name => name}))
    end
    stylists
  end

  define_method(:==) do |other|
    self.id == other.id
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:find) do |id|
    Stylist.all().each() do |stylist|
      if stylist.id == id
        return stylist
      end
    end
  end
  
end
