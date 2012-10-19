class RandomGaussian
  def initialize(mean=0, standard_deviation=1, rand_helper = lambda { Kernel.rand })
    @rand_helper = rand_helper
    @mean = mean
    @standard_deviation = standard_deviation
    @valid = false
    @next = 0
  end

  def rand
    if @valid then
      @valid = false
      return @next
    else
      @valid = true
      x, y = self.class.gaussian(@mean, @standard_deviation, @rand_helper)
      @next = y
      return x
    end
  end

  private
  def self.gaussian(mean, standard_deviation, rand)
    theta = 2 * Math::PI * rand.call
    rho = Math.sqrt(-2 * Math.log(1 - rand.call))
    scale = standard_deviation * rho
    x = mean + scale * Math.cos(theta)
    y = mean + scale * Math.sin(theta)
    return x, y
  end
end
