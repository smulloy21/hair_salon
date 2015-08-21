require('spec_helper')

describe(Stylist) do

  describe('#name') do
    it('returns a stylists name') do
      test_stylist = Stylist.new({:name => 'Megan'})
      expect(test_stylist.name()).to(eq('Megan'))
    end
  end

  describe('#id') do
    it('returns the id of the stylist') do
      test_stylist = Stylist.new({:name => 'Megan'})
      test_stylist.save()
      expect(test_stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('should be empty at first') do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('#==') do
    it('considers equal stylists with the same id') do
      test_stylist = Stylist.new({:name => 'Megan'})
      test_stylist2 = Stylist.new({:name => 'Megan'})
      expect(test_stylist).to(eq(test_stylist2))
    end
  end

  describe('#save') do
    it('saves a stylist to the database') do
      test_stylist = Stylist.new({:name => 'Megan'})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe('.find') do
    it('finds a stylist by id') do
      test_stylist = Stylist.new({:name => 'Megan'})
      test_stylist.save()
      expect(Stylist.find(test_stylist.id())).to(eq(test_stylist))
    end
  end

  describe('#update') do
    it('updates a stylists name') do
      test_stylist = Stylist.new({:name => 'Megan'})
      test_stylist.save()
      test_stylist.update({:name => 'Meg'})
      expect(test_stylist.name()).to(eq('Meg'))
    end
  end

  describe('#clients') do
    it('lists the clients of a stylist') do
      test_stylist = Stylist.new({:name => 'Megan'})
      test_stylist.save()
      test_client = Client.new({:name => 'Jane', :phone => 555-3435})
      test_client.save()
      test_client.update({:stylist_id => test_stylist.id()})
      test_client2 = Client.new({:name => 'Steve', :phone => 555-3435})
      test_client2.save()
      expect(test_stylist.clients()).to(eq([test_client]))
    end
  end

  describe('#delete') do
    it('deletes a stylist from the database') do
      test_stylist = Stylist.new({:name => 'Megan'})
      test_stylist.save()
      test_stylist.delete()
      expect(Stylist.find(test_stylist.id())).to(eq([]))
    end
    it('deletes clients when their stylist is deleted') do
      test_stylist = Stylist.new({:name => 'Megan'})
      test_stylist.save()
      test_client = Client.new({:name => 'Steve', :phone => 555-3435, :stylist_id => test_stylist.id()})
      test_client.save()
      test_stylist.delete()
      test_client.remove_stylist()
      expect(test_client.stylist_id).to(eq(nil))
    end
  end

end
