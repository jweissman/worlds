class Array
  def sum
    inject(0) {|r,i| r + i}
  end
  alias :total :sum

  def mean
    sum.to_f/count
  end
  alias :average :mean

  def sum_of_squares
    inject(0) {|r,i| r+i**2}
  end

end