# frozen_string_literal: true

module FiskalyRuby
  module SignAt
    module SignatureCreationUnits
      # SIGN AT APIs  {https://developer.fiskaly.com/api/rksv/v1#tag/Signature-Creation-Units/operation/createSignatureCreationUnit create SCU request}
      #
      # Create Signature Creation Unit
      #
      # Create a new SCU
      class Create < Base
        attr_reader :scu_id

        def initialize(token:, scu_id:, payload: {})
          super(token: token, payload: payload)

          @scu_id = scu_id
        end

         # Execute SCU creation
        #
        # @return [Hash] Formatted response informations
        def call
          _validate_params
          # PUT https://rksv.fiskaly.com/api/v1/signature-creation-unit/{signature_creation_unit_id}
          response = self.class.put("/signature-creation-unit/#{scu_id}", headers: headers, body: body)

          handle_response(response)
        end
      end
    end
  end
end
