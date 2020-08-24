require 'spec_helper'

module Api
  describe CookiesController do
    let(:user) { FactoryGirl.create(:user) }
    let(:cookie) { create(:cookie) }

    describe 'GET show' do
      let(:cookie_id) { cookie.id }
      let(:the_request) { get :show, params: { id: cookie_id } }

      context "when not authenticated" do
        before { sign_in nil }

        it "blocks access" do
          the_request
          expect(response).to redirect_to new_user_session_path
        end
      end

      context "when authenticated" do
        before { sign_in user }

        it "allows access" do
          the_request
          expect(response).to_not be_a_redirect
        end

        context "when cookie does not exist" do
          let(:cookie_id) { -1 }

          it "is not successful" do
            expect {
              the_request
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
  
        context 'when cookie exists' do
          it "is successful" do
            the_request
            expect(response.success?).to eq(true)
          end
        end

      end
    end

  end
end