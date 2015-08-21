require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

require('spec_helper')

describe('adding a new stylist', {:type => :feature}) do
  it('allows a user to add a stylist') do
    visit('/')
    fill_in('stylist_name', :with =>'Sara')
    click_button('Add stylist')
    expect(page).to have_content('Sara')
  end
end

describe('adding a new client', {:type => :feature}) do
  it('allows a user to add a client') do
    visit('/')
    fill_in('name', :with =>'Jim')
    fill_in('phone', :with =>'345-2323')
    click_button('Add client')
    expect(page).to have_content('Jim')
  end
end

describe('updating a stylist', {:type => :feature}) do
  it('allows a user to update a stylists name') do
    stylist = Stylist.new({:name => "Grace"})
    stylist.save
    visit('/')
    click_link("Grace")
    fill_in('name', :with =>'Gracie')
    click_button('Update')
    expect(page).to have_content('Gracie')
  end
end

describe('deleting a stylist', {:type => :feature}) do
  it('allows a user to delete a stylist') do
    stylist = Stylist.new({:name => "Jen"})
    stylist.save
    visit('/')
    click_link("Jen")
    click_button('Delete')
    expect(page).to have_no_content('Jen')
  end
end

describe('updating a client', {:type => :feature}) do
  it('allows a user to update a clients name or phone or both') do
    client = Client.new({:name => "Bob", :phone => '576-2736'})
    client.save
    visit('/')
    click_link("Bob")
    fill_in('name', :with =>'Bobby')
    fill_in('phone', :with =>'576-2735')
    click_button('Update')
    expect(page).to have_content('Bobby')
  end
end

describe('deleting a client', {:type => :feature}) do
  it('allows a user to delete a client') do
    client = Client.new({:name => "Tom", :phone => '867-5309'})
    client.save
    visit('/')
    click_link("Tom")
    click_button('Delete')
    expect(page).to have_no_content('Tom')
  end
end

describe('choosing a stylist', {:type => :feature}) do
  it('allows a client to select a stylist') do
    stylist = Stylist.new({:name => "Joy"})
    stylist.save
    client = Client.new({:name => "Tim", :phone => '867-5309'})
    client.save
    visit('/')
    click_link("Tim")
    click_button("Choose stylist")
    expect(page).to have_content('Joy')
  end
end

describe('removing a stylist', {:type => :feature}) do
  it('allows a client to remove a stylist') do
    stylist = Stylist.new({:name => "Fiona"})
    stylist.save
    client = Client.new({:name => "Tex", :phone => '867-5309'})
    client.save
    visit('/')
    click_link("Tex")
    click_button("Choose stylist")
    click_button("Remove stylist")
    expect(page).to have_no_content('Stylist: Fiona')
  end
end

describe('listing a stylists clients', {:type => :feature}) do
  it('lists the clients of a stylist on tehir page') do
    stylist = Stylist.new({:name => "Jean"})
    stylist.save
    client = Client.new({:name => "Sally", :phone => '867-5309', :stylist_id => stylist.id()})
    client.save
    visit('/')
    click_link("Jean")
    expect(page).to have_no_content('Sally')
  end
end
