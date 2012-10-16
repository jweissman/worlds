class Matrix
  def []=(i,j,x)
    @rows[i][j] = x
  end
end

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
  #
  def self.decomposition(matrix)
    n = matrix.row_size
    result = Matrix.build(n,n) { 0 } #empty(n,n)
    n.times do |i|
      n.times do |j|
        if i==j
          val = (0...j).to_a.inject(0) do |sum,k|
            sum += result[j,k]**2
            sum
          end
          result[j,j] = Math.sqrt(matrix[j,j] - val)
        elsif i>j
          val = (0...j).to_a.inject(0) do |sum,k|
            sum += result[i,k]*result[j,k]
            sum
          end
          result[i,j] = (1/result[j,j])*(matrix[i,j] - val)
        end
      end
    end
    return result
  end
end