require_relative 'spec_helper'

describe 'genre' do
  before(:each) do
    @genre = Genre.new('Pop')
  end

  context 'testing Genre class' do
    it 'create the instance of Genre class' do
      expect(@genre).to be_an_instance_of(Genre)
    end
    it 'should return the length of items' do
      album = MusicAlbum.new(name: 'Lover', on_spotify: true, publish_date: '2023-04-25')
      @genre.add_item(album)
      expect(@genre.items.length).to eql 1
    end
  end
end
