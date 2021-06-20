module ActiveRecord
  module Bitemporal
    module StringHalfWidthSize
      refine String do
        # 半角換算のサイズ
        def half_width_size
          length + chars.reject(&:ascii_only?).length
        end
      end
    end

  end
end
