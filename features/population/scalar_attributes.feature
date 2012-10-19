Feature: generate pseudorandom scalar attributes
  in order to quickly create complex domains
  a world creator should be able to create populations with pseudorandom scalar attributes

  Scenario: single scalar feature
    Given a feature "height" with mean 70 and standard deviation 30
     When a large population is sampled
     Then the empirical rule should hold

  Scenario: two scalar features
    Given a feature "height" with mean 80 and standard deviation 20
      And a feature "weight" with mean 150 and standard deviation 15
     When a large population is sampled
     Then the empirical rule should hold

  Scenario: multiple scalar features
    Given a feature "height" with mean 80 and standard deviation 20
      And a feature "weight" with mean 150 and standard deviation 15
      And a feature "foot size" with mean 12 and standard deviation 2
     When a large population is sampled
     Then the empirical rule should hold
