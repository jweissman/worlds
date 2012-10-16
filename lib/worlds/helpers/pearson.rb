class Pearson
  #def self.score(x, y)
  #
  #  n = x.length
  #  sigma_x = x.inject(0.0) { |r,i| r+i }
  #  sigma_y = y.inject(0.0) { |r,i| r+i }
  #
  #  sigma_x_squared = x.inject(0.0) { |r,i| r+i**2 }
  #  sigma_y_squared = y.inject(0.0) { |r,i| r+i**2 }
  #
  #  products=[]
  #  x.each_with_index do |this_x, i|
  #    products << this_x*y[i]
  #  end
  #
  #  sigma_products = products.inject(0) { |r,i| r+i }
  #
  #  # calculate pearson score
  #  num = sigma_products-(sigma_x*sigma_y/n)
  #  den=((sigma_x_squared-(sigma_x**2)/n)*(sigma_y_squared-(sigma_y**2)/n))**0.5
  #  score = den == 0 ? 0 : num/den
  #  #score = 0 if den==0
  #  #num/den
  #  p score
  #  score
  #end

  def self.score(x,y)
    n=x.length

    sumx=x.inject(0) {|r,i| r + i}
    sumy=y.inject(0) {|r,i| r + i}

    sumxSq=x.inject(0) {|r,i| r + i**2}
    sumySq=y.inject(0) {|r,i| r + i**2}

    prods=[]; x.each_with_index{|this_x,i| prods << this_x*y[i]}
    pSum=prods.inject(0){|r,i| r + i}

    # Calculate Pearson score
    num=pSum-(sumx*sumy/n)
    den=((sumxSq-(sumx**2)/n)*(sumySq-(sumy**2)/n))**0.5
    if den==0
      return 0
    end
    r=num/den
    return r
  end
end