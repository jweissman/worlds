class Pearson
  def self.score(x, y)

    n = x.length
    sigma_x = x.inject(0.0) { |r,i| r+i }
    sigma_y = y.inject(0.0) { |r,i| r+i }

    sigma_x_squared = x.inject(0.0) { |r,i| r+i**2 }
    sigma_y_squared = y.inject(0.0) { |r,i| r+i**2 }

    products=[]
    x.each_with_index do |_x, i|
      products << _x*y[i]
    end

    sigma_products = products.inject(0.0) { |r,i| r+i }

    # calculate pearson score
    num = sigma_products-(sigma_x*sigma_y/n)
    den=((sigma_x_squared-(sigma_x**2)/n)*(sigma_y_squared-(sigma_y**2)/n))**0.5
    return 0 if den==0
    num/den
  end
end