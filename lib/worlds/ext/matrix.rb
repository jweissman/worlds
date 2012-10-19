class Matrix
  #
  #   Hack the Matrix -- and make it mutable.
  #
  #   TODO refactor business logic that uses this to use arrays instead...
  #   Shouldnt really be that bad, and I hate doing this sort of thing.
  #
  def []=(i,j,x)
    @rows[i][j] = x
  end
end