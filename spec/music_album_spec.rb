require_relative 'spec_helper'

describe 'MusicAlbum' do
  before(:each) do
    @album = MusicAlbum.new(name: 'Lover', on_spotify: true, publish_date: '2023-04-25')
  end

  context 'testing MusicAlbum class' do
    it 'create the instance of MusicAlbum class' do
      expect(@album).to be_an_instance_of(MusicAlbum)
    end

    it 'should return the correct date' do
      expect(@album.publish_date).to eql('2023-04-25')
    end

    it 'should return correct spotify status' do
      expect(@album.on_spotify).to eql(true)
    end
  end
end
