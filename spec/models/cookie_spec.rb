require 'rails_helper'

describe Cookie do
  subject { Cookie.new }

  describe "associations" do
    it { is_expected.to belong_to(:storage) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:storage) }
  end

  describe '#ready?' do
    context 'when ready_at is nil' do
      it 'equals false' do
        expect(subject.ready?).to eq(false)
      end
    end    

    context 'when ready_at is set' do
      before { subject.update(ready_at: DateTime.current) }
      
      it 'equals true' do
        expect(subject.ready?).to eq(true)
      end
    end
  end

end
