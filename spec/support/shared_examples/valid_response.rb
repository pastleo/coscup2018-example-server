# frozen_string_literal: true

RSpec.shared_examples 'valid response' do
  it { expect(response).to have_http_status(200) }
end
