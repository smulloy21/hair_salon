require('spec_helper')

describe(Stylist) do

  describe('#name') do
    it('returns a stylists name') do
      test_stylist = Stylist.new({:name => 'Megan'})
      expect(test_stylist.name()).to(eq('Megan'))
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

end
