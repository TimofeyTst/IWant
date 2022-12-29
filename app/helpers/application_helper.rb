module ApplicationHelper
  def arr_by_three_columns(arr)
    result = [[], [], []]
    arr.each_with_index do |el, index|
      result[index % 3].push(el)
    end
    result
  end

  def toggled_theme
    current_user.theme == 'light' ? 'dark' : 'light'
  end
end
