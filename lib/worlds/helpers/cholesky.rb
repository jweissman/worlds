class Cholesky
  #
  #   Cholesky-Banachiewicz algorithm.
  #
  #   We start from the upper left corner of the matrix and proceed to calculate the resultant
  #   matrix row-by-row.
  #
  #   Assumptions:
  #     - matrix is square
  #
  #   TODO: refactor not to rely on mutable matrix.
  #
  #
  def self.decomposition(matrix)
    # some sanity checks
    raise "Argument to Cholesky.decomposition must be a Matrix" unless matrix.is_a? Matrix
    raise "Argument to Cholesky.decomposition must be a square Matrix" unless matrix.square?
    n = matrix.row_size
    result = Matrix.build(n,n) { 0 }
    n.times do |i|
      n.times do |j|
        if i==j
          val = (0...j).to_a.inject(0) { |sum,k| sum + result[j,k]**2 }
          result[j,j] = Math.sqrt(matrix[j,j] - val)
        elsif i>j
          val = (0...j).to_a.inject(0) { |sum,k| sum + result[i,k]*result[j,k] }
          result[i,j] = (1/result[j,j])*(matrix[i,j] - val)
        end
      end
    end
    return result
  end
end