# frozen_string_literal: true

module FiskalyRuby
  module SignAt
    module CashRegisters
      # SIGN AT APIs {https://developer.fiskaly.com/api/rksv/v1#tag/Cash-Registers/operation/updateCashRegister Update a Cash Register}
      #
      # Update a Cash Register
      # This endpoint updates a Cash Register.
      # In order to be able to use a Cash Register for signing Receipts it needs to be transitioned to the state INITIALIZED.
      # Once a Cash Register has eventually reached its end-of-life this has to be reflected by setting its state to DECOMMISSIONED.
      #
      # Update a Cash Register
      class Update < Base


        # Available TSS states
        STATES = %i(REGISTERED INITIALIZED DECOMMISSIONED DEFECTIVE OUTAGE).freeze

        attr_reader :cash_register_id

        # Required payload attributes
        #
        # @return [Array] Set of required attributes
        def required_payload_attributes
          %i(state)
        end

        # Optional payload attributes
        #
        # @return [Array] Set of optional attributes
        def optional_payload_attributes
          %i(description metadata)
        end

        # @param token [String] JWT token
        # @param cash_register_id [String] cash_register_id UUID
        # @param payload [Hash] Payload of request
        # @return [FiskalyRuby::KassenSichV::TSS::Update] The Update object
          def initialize(token:, cash_register_id:, payload: {})
          super(token: token, payload: payload)

          @cash_register_id = cash_register_id
        end

        # Execute tss update
        #
        # @return [Hash] Formatted response informations
        def call
          _validate_params
          # PATH https://rksv.fiskaly.com/api/v1/cash-register/{cash_register_id}
          response = self.class.patch("/cash-register/#{cash_register_id}", headers: headers, body: body)

          handle_response(response)
        end

        private

        # Validate parameters
        #
        # @return NilClass
        def _validate_params
          _validate_states
          _validate_metadata
        end

        # Validate states parameters
        #
        # @return NilClass
        def _validate_states
          state = payload[:state]

          raise "Invalid state for: #{state.inspect}" unless STATES.include?(state)
        end
      end
    end
  end
end
