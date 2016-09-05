# frozen_string_literal: true
require 'spec_helper'
require 'shared_contexts/having_configured_client'

describe OzonApi::ClientService do
  include_context 'having configured client'

  let(:subject) { described_class.new(client) }
  let(:client_id) { 'hb1' }
  let(:email) { 'user@httplab.ru' }
  let(:password) { 'userhttplab' }
  let(:first_name) { 'Phillip' }
  let(:last_name) { 'Morris' }

  let(:vcr_options) do
    ['client_service', { record: :new_episodes,  match_requests_on: [:method, :uri] }]
  end

  describe '#client_check_email' do
    context 'given existed email' do
      it 'returns true' do
        VCR.use_cassette(*vcr_options) do
          verify(format: :json) { subject.client_check_email(email) }
        end
      end
    end

    context 'given not existed email' do
      let(:email) { 'not-user@httplab.ru' }

      it 'returns error' do
        VCR.use_cassette(*vcr_options) do
          verify(format: :json) { subject.client_check_email(email) }
        end
      end
    end
  end

  describe '#client_registration' do
    it 'returns status 2' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.client_registration(
            client_id,
            email,
            password,
            first_name,
            last_name
          )
        end
      end
    end
  end

  describe '#client_login' do
    context 'given existed client' do
      it 'returns status 2' do
        VCR.use_cassette(*vcr_options) do
          verify(format: :json) { subject.client_login(client_id, email, password) }
        end
      end
    end

    context 'given not existed client' do
      let(:email) { 'not-user@httplab.ru' }

      it 'returns error' do
        VCR.use_cassette(*vcr_options) do
          verify(format: :json) { subject.client_login(client_id, email, password) }
        end
      end
    end
  end
end
