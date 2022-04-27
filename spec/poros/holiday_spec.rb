require 'rails_helper'

RSpec.describe 'the_api' do
  it "exists and has attributes" do
    days = [{Name: 'Skydiving Day'}, {Name: 'Drew day'}, {Name: 'Code day'}]
    holidays = Holiday.new(days)


    expect(holidays.three_holidays[0]).to eq('Skydiving day')
    expect(holidays.three_holidays[1]).to eq('Drew day')
    expect(holidays.three_holidays[2]).to eq('Code day')
  end
end
