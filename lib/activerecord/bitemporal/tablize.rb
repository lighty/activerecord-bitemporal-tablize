require_relative 'tablize/version'
require 'lib/activerecord/bitemporal/tablize/string_half_width_size'

class ActiveRecord::Bitemporal::Tablize
  using StringHalfWidthSize

  attr :records, :result, :attributes

  def initialize(records:, attributes: [])
    @records = records.map { |record| RecordWrapper.new(record, self) }
    @attributes = attributes
    @result = []
  end

  def call
    append_header
    append_body
    result.join("\n") + "\n"
  end

  def max_width_of(attribute)
    [max_attribute_size_of(attribute), attribute.to_s.half_width_size].max
  end

  def max_attribute_size_of(attribute)
    # @max_attribute_sizes = {} キャッシュしたほうが良い
    records.map { |r| r.send(attribute).to_s.half_width_size }.max
  end

  def build_node(value, padding = ' ')
    padding + value + padding
  end

  private

  def append_header
    result << "+#{build_roof.join('+')}+"
    result << "|#{build_wall.join('|')}|"
  end

  def build_roof
    ([:valid_from] + attributes).map do |attribute|
      build_node('-' * max_width_of(attribute), '-')
    end
  end

  def build_wall
    duration_node = build_node(' ' * max_width_of(:valid_from), ' ')
    [duration_node] + attributes.map do |attribute|
                        padding = [max_width_of(attribute) - attribute.to_s.half_width_size, 0].max
                        build_node(attribute.to_s + (' ' * padding), ' ')
                      end
  end

  def append_body
    records.each do |record|
      result << "+#{record.build_roof.join('+')}+"
      result << "|#{record.build_wall.join('|')}|"
      result << "+#{record.build_roof.join('+')}+"
    end
  end

  class RecordWrapper
    delegate_missing_to :record
    delegate :build_node, :max_width_of, :max_attribute_size_of, to: :tablize

    def initialize(record, tablize)
      @record = record
      @tablize = tablize
    end

    def valid_to
      record.valid_to.strftime('%Y/%m/%d')
    end

    def valid_from
      record.valid_from.strftime('%Y/%m/%d')
    end

    def max_attribute_size_of(attribute)
      tablize.max_attribute_size_of(attribute)
    end

    def build_roof
      build_cap(:valid_to)
    end

    def build_floor
      build_cap(:valid_from)
    end

    def build_cap(duration_attribute)
      duration_node = build_node(send(duration_attribute).to_s, '-')
      [duration_node] + tablize.attributes.map do |attribute|
                          build_node('-' * max_width_of(attribute), '-')
                        end
    end

    def build_wall
      duration_node = build_node(' ' * max_width_of(:valid_from), ' ')
      [duration_node] + tablize.attributes.map do |attribute|
                          padding = [max_width_of(attribute) - send(attribute).to_s.half_width_size, 0].max
                          build_node(send(attribute).to_s + (' ' * padding), ' ')
                        end
    end

    private

    attr :record, :tablize
  end
end
