# frozen_string_literal: true

module FiskalyRuby
  module SignAt
    module CashRegisters
      # SIGN AT APIs {https://developer.fiskaly.com/api/rksv/v1#tag/Cash-Registers/operation/createCashRegister Create a Cash Register}
      #
      # Create a Cash Register
      # This endpoint creates a Cash Register. The Cash Register is identified by a cash_register_id. The cash_register_id must comply with the UUIDv4 standard and should be generated on your side.
      # When you create a Cash Register, its state is set to CREATED.
      # Use the Update a Cash Register endpoint to transition a Cash Register to the state INITIALIZED in order to be able to use it for signing Receipts.
      #
      # Create a Cash Register
      class Create < Base
        attr_reader :cash_register_id

        def initialize(token:, cash_register_id:, payload: {})
          super(token: token, payload: payload)

          @cash_register_id = cash_register_id
        end

         # Execute SCU creation
        #
        # @return [Hash] Formatted response informations
        def call

          # PUT https://rksv.fiskaly.com/api/v1/cash-register/{cash_register_id}
          response = self.class.put("/cash-register/#{cash_register_id}", headers: headers, body: body)

          handle_response(response)
        end
      end
    end
  end
end
