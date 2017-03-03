require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'has a valid factory' do
    game_count = Game.count
    expect(FactoryGirl.create(:game)).to be_valid
    expect(Game.count).to eq game_count + 1       
  end

end
