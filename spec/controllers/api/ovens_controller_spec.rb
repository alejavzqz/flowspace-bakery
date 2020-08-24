require 'spec_helper'

module Api
  describe OvensController do
    let(:user) { FactoryGirl.create(:user) }
    let(:oven) { create(:oven) }

    describe 'GET show' do
      let(:oven_id) { oven.id }
      let(:the_request) { get :show, params: { id: oven_id } }

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

        context "when oven does not exist" do
          let(:oven_id) { -1 }

          it "is not successful" do
            expect {
              the_request
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
  
        context 'when oven exists' do
          it "is successful" do
            the_request
            expect(response.success?).to eq(true)
          end
        end

      end
    end

  end
end