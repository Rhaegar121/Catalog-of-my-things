require './Classes/label'

describe Label do
  before :all do
    @label = Label.new(title: 'Super Awesome Label', color: 'red')
  end

  describe '#initialize' do
    it 'takes two parameters and returns a Label object' do
      expect(@label).to be_an_instance_of Label
    end

    it 'should have a name' do
      expect(@label.title).to eq('Super Awesome Label')
    end
  end

  describe '#add_item' do
    context 'when item is an instance of Item' do
      it 'should add the item to the label' do
        @item = Item.new
        expect { @label.add_item(@item) }.to output("Item Added\n").to_stdout
      end
    end

    context 'when item already has a different label' do
      it 'should return an error' do
        @item = Item.new
        @label2 = Label.new(title: 'Another Label', color: 'blue')
        @label2.add_item(@item)
        expect { @label.add_item(@item) }.to output("!! Item already has a different label !!\n").to_stdout
      end
    end

    context 'when item already has this label' do
      it 'should return an error' do
        @item = Item.new
        @label.add_item(@item)
        expect { @label.add_item(@item) }.to output("!! Item already has this label !!\n").to_stdout
      end
    end
  end
end
