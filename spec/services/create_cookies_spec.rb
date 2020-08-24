require 'rails_helper'

describe CreateCookies do
  
  subject(:create_cookies) { CreateCookies.new }
  let(:oven) { create(:oven) }

  describe '#call' do
    let(:params) { { fillings: rand(1..100), amount: rand(1..5) } }

    context 'when amount is an empty value' do
      before { params.delete(:amount) }

      it 'creates 1 cookie' do
        expect{ create_cookies.call(oven, params) }.to change(oven.cookies, :count).by(1)

        [nil, '', 0].each do |val|
          params[:amount] = val
          expect{ create_cookies.call(oven, params) }.to change(oven.cookies, :count).by(1)
        end
      end

      it 'schedules 1 CookCookieJob' do
        expect(CookCookieJob).to receive(:perform_later).exactly(1)
        create_cookies.call(oven, params)
      end
    end

    context 'when amount is an integer value' do
      it 'creates that many cookies' do
        expect {
          create_cookies.call(oven, params)
        }.to change(oven.cookies, :count).by(params[:amount])
      end

      it 'CookCookieJob recieves perform_later that many times' do
        expect(CookCookieJob).to receive(:perform_later).exactly(params[:amount])
        create_cookies.call(oven, params)
      end
    end
  end

end