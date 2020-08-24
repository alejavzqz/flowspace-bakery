require 'rails_helper'

describe CookCookieJob do
  include ActiveJob::TestHelper

  let(:cookie) { create(:cookie) }
  subject(:job) { CookCookieJob.perform_later(cookie.id) }

  describe '#perform' do
    context 'if cookie is already ready' do
      before { cookie.update(ready_at: DateTime.current) }

      it 'does not initialize CookCookie' do
        expect(CookCookie).to_not receive(:new)
        perform_enqueued_jobs { job }
      end
    end

    context 'if cookie is not ready' do
      it 'calls a CookCookie' do
        expect_any_instance_of(CookCookie).to receive(:call)
        perform_enqueued_jobs { job }
      end
    end
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
