Feature: generate populations with a mix of scalar and categorical attributes
  In order to quickly simulate complex domains
  should be able to randomly generate a population with a mix of scalar and categorical attributes

  Scenario: a mix of scalar and categorical features
    Given a feature "height" with mean 65 and standard deviation 10
      And a feature "weight" with mean 150 and standard deviation 20
      And a feature "gender" with the following values:
        | male    |
        | female  |
        | other   |
      And a feature "species" with the following values:
        | human        |
        | alien        |
        | machine      |
     When a large population is sampled
     Then I should see the following individuals:
        | species | gender |
        |  human  |  male  |
        |  alien  | female |
        | machine |  other |
      And the empirical rule should hold
