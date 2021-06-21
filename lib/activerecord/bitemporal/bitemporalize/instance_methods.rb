module ActiveRecord
  module Bitemporal
    module Bitemporalize
      module InstanceMethods
        def histories
          records = begin
                      super
                    rescue NoMethodError
                      self.class.ignore_valid_datetime.bitemporal_for(bitemporal_id).order(valid_from: :desc)
                    end

          records.define_singleton_method(:print_table) do |*attributes|
            print ActiveRecord::Bitemporal::Tablize.new(records: records, attributes: attributes).call
          end

          records.define_singleton_method(:print_table_diff_only) do |*attributes|
            print ActiveRecord::Bitemporal::Tablize.new(records: records, attributes: attributes, diff_only: true).call
          end

          records
        end
      end
    end
  end
end
