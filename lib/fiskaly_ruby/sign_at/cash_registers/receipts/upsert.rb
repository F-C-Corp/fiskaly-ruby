# frozen_string_literal: true

module FiskalyRuby
  module SignAt
    module CashRegisters
      module Receipts
        # SIGN AT APIs {https://developer.fiskaly.com/api/rksv/v1#tag/Receipts/operation/signReceipt Sign a Receipt}
        #
        # Sign a Receipt
        # This endpoint signs a Receipt. Hence, it is the single most important endpoint for day-to-day operations.
        # The response contains all information that is necessary for augmenting the final receipt which is handed out to the customer:
        #   1. qr_code_data, which contains the data for the RKSV QR Code to be displayed in a graphical representation,
        #   2. as well as information that needs to be displayed in textual form: receipt_number, time_signature and cash_register_serial_number,
        #   3. all raw gross amounts.
        #
        # Sign a Receipt
        class Upsert < Base
          attr_reader :cash_register_id
          attr_reader :receipt_id

          # Available Receipts states
          RECEIPTTYPES = %i(NORMAL CANCELLATION TRAINING).freeze

          # Required payload attributes
          #
          # @return [Array] Set of required attributes
          def required_payload_attributes
            %i(schema receipt_type)
          end

          # @param token [String] JWT token
          # @param cash_register_id [String] CashRegisters UUID
          # @param receipt_id [String] receipt_id UUID
          # @param payload [Hash] Payload of request
          def initialize(token:, cash_register_id:, receipt_id:, payload: {})
            super(token: token, payload: payload)

            @cash_register_id = cash_register_id
            @receipt_id = receipt_id
          end

          # Execute SCU creation
          #
          # @return [Hash] Formatted response informations
          def call
            _validate_params
            # PUT https://rksv.fiskaly.com/api/v1/cash-register/{cash_register_id}/receipt/{receipt_id}
            response = self.class.put("/cash-register/#{cash_register_id}/receipt/#{receipt_id}", headers: headers, body: body)

            handle_response(response)
          end

          private

          # Validate parameters
          #
          # @return NilClass
          def _validate_params
            _validate_metadata
            _validate_receipt_type
            _validate_schema
          end

          # Validate state parameter
          #
          # @return NilClass
          def _validate_receipt_type
            receipt_type = payload[:receipt_type]

            raise "Invalid state for: #{receipt_type.inspect}" unless RECEIPTTYPES.include?(receipt_type)
          end


          def _validate_schema
            schema = payload[:schema]
            receipt_type = payload[:receipt_type]

            return unless schema.nil?

            raise _schema_error_message
          end

          def _schema_error_message
            <<~ERROR_MESSAGE
              Missing payload 'schema' attribute.
              then payload 'schema' attribute must be filled with this structure:
              {
                schema: {
                  standard_v1: {
                    amounts_per_vat_rate: [
                      {
                        vat_rate:,
                        amount:
                      }
                    ],
                    amounts_per_payment_type:[
                      {
                      payment_type:,
                      amount:,
                      currency_code:
                      }
                    ],
                    line_items: [
                      {
                        quantity:,
                        text:,
                        price_per_unit:
                      }
                    ]
                  }
                }
              }
            ERROR_MESSAGE
          end

        end
      end
    end
  end
end
