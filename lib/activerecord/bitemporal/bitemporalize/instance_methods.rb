module ActiveRecord
  module Bitemporal
    module Bitemporalize
      module InstanceMethods

        def print_histories(*attributes)
          print ActiveRecord::Bitemporal::Tablize.new(records: ordered_histories, attributes: attributes).call
        end

        def print_histories_diff
          print ActiveRecord::Bitemporal::Tablize.new(records: ordered_histories, diff_only: true).call
        end

        private

        def ordered_histories
          if respond_to?(:histories)
            histories
          else
            self.class.ignore_valid_datetime.bitemporal_for(bitemporal_id)
          end.order(valid_from: :desc)
        end
      end
    end
  end
end
