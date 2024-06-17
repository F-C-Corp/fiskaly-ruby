# frozen_string_literal: true

module FiskalyRuby
  module SignAt
    module Fon
      #  SIGN AT APIs {https://developer.fiskaly.com/api/rksv/v1#tag/FON/operation/authenticateFon Authenticate FON}
      #
      # Authenticate FON
      # The fiscalization process requires interactions with FinanzOnline (FON). This includes registering Cash Registers and Signature Creation Units, validating Receipts, etc. The fiskaly SIGN AT automates all those steps.
      # Our system communicates with FinanzOnline (FON) in the name of the taxpayer. The taxpayer must create a FinanzOnline Cash Register web service user ("Registrierkassen-Webservice-Benutzer", pages 60-63). Then you must use those credentials to authenticate the taxpayer with FON through this endpoint.
      # Note: The credentials of this Cash Register Web Service User must be provided only once for authenticating with FON. The Cash Register web service user remains authenticated with FON indefinitely.
      # Note: You must authenticate with FON before transitioning Signature Creation Units and Cash Registers to INITIALIZED.
      # Note: For requests requiring our system to communicate with FinanzOnline (FON), any downtime or unavailability of the FinanzOnline (FON) service may impact such requests.
      #
      # Authenticate FON
      class Authenticate < Base

        # Required payload attributes
        #
        # @return [Array] Set of required attributes
        def required_payload_attributes
          %i(fon_participant_id fon_user_id fon_user_pin)
        end

        # Execute authentication
        #
        # @return [Hash] Formatted response informations
        def call
          # PUT https://rksv.fiskaly.com/api/v1/fon/auth}
          response = self.class.put('/fon/auth', headers: headers, body: body)

          handle_response(response)
        end
      end
    end
  end
end
