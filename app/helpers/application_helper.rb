module ApplicationHelper
  def arr_by_three_columns(arr)
    result = [[], [], []]
    arr.each_with_index do |el, index|
      result[index % 3].push(el)
    end
    result
  end
end
