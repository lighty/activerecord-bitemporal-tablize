module ActiveRecord
  module Bitemporal
    module Bitemporalize
      module InstanceMethods
        def history
          self.class.ignore_valid_datetime.bitemporal_for(bitemporal_id).order(valid_from: :desc).tap do |records|
            records.define_singleton_method(:print_table) do |*attributes|
              print ActiveRecord::Bitemporal::Tablize.new(records: records, attributes: attributes).call
            end
          end
        end
      end
    end
  end
end
