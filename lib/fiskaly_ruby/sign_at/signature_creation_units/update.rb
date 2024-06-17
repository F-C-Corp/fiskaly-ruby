# frozen_string_literal: true

module FiskalyRuby
  module SignAt
    module SignatureCreationUnits
      # SIGN AT APIs  {https://rksv.fiskaly.com/api/v1/signature-creation-unit/{signature_creation_unit_id Update a Signature Creation Unit}
      #
      # Update Signature Creation Unit
      #
      # This endpoint updates a Signature Creation Unit.
      # In order to be able to use a Signature Creation Unit for signing Receipts it needs to be transitioned to the state INITIALIZED.
      # Once a Signature Creation Unit has eventually reached its end-of-life this has to be reflected by setting its state to DECOMMISSIONED.
      #
      #
      # Update a new SCU
      class Update < Base
        attr_reader :scu_id

        # Available SCU states
        STATES = %i(INITIALIZED DECOMMISSIONED).freeze

        def initialize(token:, scu_id:, payload: {})
          super(token: token, payload: payload)

          @scu_id = scu_id
        end

        # Required payload attributes
        #
        # @return [Array] Set of required attributes
        def required_payload_attributes
          %i(state)
        end

        # Execute SCU creation
        #
        # @return [Hash] Formatted response informations
        def call
          _validate_params
          # PATCH https://rksv.fiskaly.com/api/v1/signature-creation-unit/{signature_creation_unit_id}
          response = self.class.patch("/signature-creation-unit/#{scu_id}", headers: headers, body: body)

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
