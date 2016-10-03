# frozen_string_literal: true
module NullStream
  def self.<<(*)
    self
  end
end

RSpec.shared_context 'having configured client' do
  let!(:config) { OzonApi.setup }
  let(:subject) { OzonApi }
end
