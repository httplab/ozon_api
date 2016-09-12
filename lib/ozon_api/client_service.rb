# frozen_string_literal: true
module OzonApi
  class ClientService
    BASE_PATH = 'ClientService'

    def initialize(client)
      @client = client
    end

    def client_check_email(email)
      @client.get([BASE_PATH, 'ClientCheckEmail'].join('/'), 'email': email)
    end

    def client_registration(id, email, password, first_name, last_name)
      params = {
        'partnerClientId': id,
        'email': email,
        'clientPassword': password,
        'firstName': first_name,
        'lastName': last_name,
        'spamSubscribe': false,
        'userIp': "''",
        'userAgent': "''"
      }

      @client.post([BASE_PATH, 'PartnerClientRegistration'].join('/'), params)
    end

    def client_login(id, email, password)
      params = {
        'partnerClientId': id,
        'clientLogin': email,
        'clientPassword': password
      }

      @client.get([BASE_PATH, 'ClientLogin'].join('/'), params)
    end
  end
end
