Feature: generate multivariate correlated pseudorandom scalar attributes
  in order to quickly create complex domains
  a world creator should be able to create populations with multivariate correlated pseudorandom scalar attributes

  Scenario: weakly-correlated scalar feature pair
    Given a feature "height" with mean 80 and standard deviation 20
      And a feature "weight" with mean 150 and standard deviation 15
      And "height" and "weight" are weakly correlated
     When a large population is sampled
     Then "height" and "weight" should be weakly correlated
      And the empirical rule should hold

  Scenario: strongly-correlated scalar feature pair
    Given a feature "height" with mean 80 and standard deviation 40
      And a feature "weight" with mean 150 and standard deviation 30
      And "height" and "weight" are strongly correlated
     When a large population is sampled
     Then "height" and "weight" should be strongly correlated
      And the empirical rule should hold

  Scenario: arbitrarily-correlated scalar feature pair
    Given a feature "height" with mean 80 and standard deviation 45
      And a feature "weight" with mean 160 and standard deviation 50
      And "height" and "weight" are 30% correlated
     When a large population is sampled
     Then "height" and "weight" should be 30% correlated
      And the empirical rule should hold

  Scenario: multiple features with covariance matrix
    Given a feature "height" with mean 80 and standard deviation 25
      And a feature "weight" with mean 150 and standard deviation 30
      And a feature "foot_size" with mean 10 and standard deviation 3
      And "height" and "weight" are strongly correlated
      And "weight" and "foot_size" are weakly correlated
      And "height" and "foot_size" are 90% correlated
     When a large population is sampled
     Then "height" and "weight" should be strongly correlated
      And "weight" and "foot_size" should be weakly correlated
      And "height" and "foot_size" should be 90% correlated
      And the empirical rule should hold
