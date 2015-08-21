require('spec_helper')

describe(Client) do
  describe('#name') do
    it('returns the name of a client') do
      test_client = Client.new({:name => 'Steve', :phone => 555-3435})
      expect(test_client.name()).to(eq('Steve'))
    end
  end
  describe('#phone') do
    it('returns the name of a client') do
      test_client = Client.new({:name => 'Steve', :phone => 555-3435})
      expect(test_client.phone()).to(eq(555-3435))
    end
  end
  describe('.all') do
    it('should be empty at first') do
      expect(Client.all()).to(eq([]))
    end
  end
  describe('#==') do
    it('considers equal clients with the same id') do
      test_client = Client.new({:name => 'Steve', :phone => 555-3435})
      test_client2 = Client.new({:name => 'Steve', :phone => 555-3435})
      expect(test_client).to(eq(test_client2))
    end
  end
  describe('#save') do
    it('saves a client to the database') do
      test_client = Client.new({:name => 'Steve', :phone => 555-3435})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end
  describe('#update') do
    it('updates a clients name and phone') do
      test_client = Client.new({:name => 'Steve', :phone => 555-3435})
      test_client.save()
      test_client.update({:name => 'Stevie', :phone => 555-3436})
      expect(test_client.name()).to(eq('Stevie'))
      expect(test_client.phone()).to(eq(555-3436))
    end
    it('updates a clients stylist') do
      test_client = Client.new({:name => 'Steve', :phone => 555-3435})
      test_client.save()
      test_client.update({:stylist_id => 5})
      expect(test_client.stylist_id()).to(eq(5))
    end
  end
end
