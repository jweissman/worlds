module StepHelpers

  def correlate(a,b,rho)
    @covariance_matrix ||= Matrix.I(@normally_distributed_features.size)
    names = @normally_distributed_features.map(&:name)
    @covariance_matrix[names.index(a),names.index(b)] = rho
  end

  def confirm_correlation(a,b,rho,tolerance=0.01)
    x,y = @sample.map { |s| s[a] }, @sample.map { |s| s[b] }
    (rho - Pearson.score(x,y)).abs.should < tolerance
  end

  def generate_sample(size=30)
    #puts "--- attempting to generate sample..."
    @features ||= []
    #puts "--- current feature list: "
    #p @features
    unless @normally_distributed_features.nil?
      if @normally_distributed_features.size <= 1
        @normally_distributed_features.each do |feature|
          @features << feature
        end
      else
        @features << CorrelatedAttributeVector.new(@normally_distributed_features, @covariance_matrix)
      end
    end
    puts "--- about to setup and #sample population after considering normally distributed features: "
    p @features

    @population = Population::Base.new(@features)
    @sample = @population.sample(size)
  end

end