module ApplicationHelper
  def each_column(array, column_count, &block)
    slice_size = (array.size / column_count.to_f).ceil
    array.each_slice(slice_size, &block)
  end
end
