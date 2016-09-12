# frozen_string_literal: true
module NullStream
  def self.<<(*)
    self
  end
end

RSpec.shared_context 'having configured client' do
  let(:client) do
    OzonApi::Client.new(out: NullStream)
  end
end
