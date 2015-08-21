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
end
