require 'spec_helper'

describe SkiBot::SessionStorage do
  context 'basic interfaces' do
    it '#get, #set' do
      expect{ SkiBot::SessionStorage.set(:a, 1) }.to change{
        SkiBot::SessionStorage.get(:a)
      }.to(1)
    end

    it '#[], #[]=' do
      expect{ SkiBot::SessionStorage[:a]= 2 }.to change{
        SkiBot::SessionStorage[:a]
      }.to(2)
    end

    it 'cleans_previous' do
      id = 123456789
      SkiBot::SessionStorage[id][:previous] = 'SkiBot::Hello'
      expect{ SkiBot::SessionStorage.clean_previous(id) }.to change{
        SkiBot::SessionStorage[id][:previous]
      }.to(nil)
    end
  end
end
