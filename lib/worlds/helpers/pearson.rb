class Pearson
  def self.score(x,y)
    n=x.length

    sumx=x.sum #inject(0) {|r,i| r + i}
    sumy=y.sum #inject(0) {|r,i| r + i}

    sumx_sq=x.sum_of_squares #inject(0) {|r,i| r + i**2}
    sumy_sq=y.sum_of_squares #inject(0) {|r,i| r + i**2}

    prods=[]; x.each_with_index{|this_x,i| prods << this_x*y[i]}
    sum_prods=prods.sum #inject(0){|r,i| r + i}

    # Calculate Pearson score
    num=sum_prods-(sumx*sumy/n)
    den=((sumx_sq-(sumx**2)/n)*(sumy_sq-(sumy**2)/n))**0.5
    if den==0
      return 0
    end
    r=num/den
    return r
  end
end