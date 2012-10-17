module StepHelpers
  def get_feature_by_name(feature_name)
    @normally_distributed_features.select { |f| f.name == feature_name }.first
  end

  def confirm_mean(feature, value, tolerance=get_feature_by_name(feature).standard_deviation/4)
    data = @sample.map { |s| s[feature].to_f }
    mean = data.inject(:+) / data.size.to_f
    (value.to_f - mean).abs.should <= tolerance.to_f
  end

  def correlate(a,b,rho)
    @covariance_matrix ||= Matrix.I(@normally_distributed_features.size)
    names = @normally_distributed_features.map(&:name)
    @covariance_matrix[names.index(a),names.index(b)] = rho
    @covariance_matrix[names.index(b),names.index(a)] = rho
  end

  def confirm_correlation(a,b,rho,tolerance=0.01)
    x,y = @sample.map { |s| s[a] }, @sample.map { |s| s[b] }
    (rho - Pearson.score(x,y)).abs.should < tolerance
  end

  def generate_sample(size=30)
    @features ||= []
    unless @normally_distributed_features.nil?
      if @normally_distributed_features.size <= 1
        @normally_distributed_features.each do |feature|
          @features << feature
        end
      else
        @features << CorrelatedAttributeVector.new(@normally_distributed_features, @covariance_matrix)
      end
    end
    @population = Population::Base.new(@features)
    @sample = @population.sample(size)
  end

end