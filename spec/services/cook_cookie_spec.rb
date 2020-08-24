require 'rails_helper'

describe CookCookie do
  subject(:cook_cookie) { CookCookie.new }

  let(:cookie) { create(:cookie) }

  describe '#call' do
    it 'calls update on cookie with current time' do
      expect(cookie).to receive(:update).with(ready_at: DateTime.current)
      cook_cookie.call(cookie)
    end

  end

end