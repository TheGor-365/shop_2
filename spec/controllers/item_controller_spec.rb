require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe 'GET #show' do
    let(:items) { create_list :item 5 }
  end

  describe 'DELETE #destroy' do

  end
end