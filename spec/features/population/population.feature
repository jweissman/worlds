Feature: generate and evolve random populations
  in order to easily create and simulate complex domains
  a world creator should be able to easily generate and evolve random populations

  Scenario: scalar features
    Given a feature height with mean 70 and standard deviation 30
    When a large population is sampled
    Then mean sample height should be 70
    And the empirical rule should apply to normally distributed features


#  Scenario: one feature with one value
#    Given a feature species with the following values:
#      | human |
#    When the population is sampled
#    Then I should see the following individuals
#      | species |
#      |  human  |
#
#  Scenario: one feature with two values
#    Given a feature species with the following values:
#      | human |
#      | alien |
#    When the population is sampled
#    Then I should see the following individuals
#      | species |
#      |  human  |
#      |  alien  |
#
#  Scenario: several features with several values
#    Given a feature gender with the following values:
#      | male   |
#      | female |
#      | other  |
#    And a feature species with the following values:
#      | human   |
#      | alien   |
#      | machine |
#    And a feature profession with the following values:
#      | merchant |
#      | priest   |
#      | soldier  |
#      | pilot    |
#    When a large population is sampled
#    Then I should see the following individuals
#      | species | gender | profession |
#      |  human  |  male  |  soldier   |
#      |  alien  | female |  merchant  |
#      | machine |  other |  priest    |

#  Scenario: a mix of scalar and categoreal features
#    Given a feature height with mean 60 and standard deviation 10
#      And a feature gender with the following values:
#       | male   |
#       | female |
#     When a large population is sampled
#     Then I should see individuals with gender 'male'
#      And the empirical rule should apply to normally distributed features

#  Scenario: weakly-correlated scalar feature pair
#    Given a feature height with mean 80 and standard deviation 40
#      And a feature weight with mean 150 and standard deviation 30
#      And height and weight are weakly correlated
#     When a large population is sampled
#     Then height and weight should be weakly correlated
#      And the empirical rule should apply to normally distributed features
#
#  Scenario: strongly-correlated scalar feature pair
#    Given a feature height with mean 80 and standard deviation 40
#      And a feature weight with mean 150 and standard deviation 30
#      And height and weight are strongly correlated
#     When a large population is sampled
#     Then height and weight should be strongly correlated
#      And the empirical rule should apply to normally distributed features
#
#  Scenario: arbitrarily-correlated scalar feature pair
#    Given a feature height with mean 80 and standard deviation 45
#      And a feature weight with mean 160 and standard deviation 50
#      And height and weight are 30 percent correlated
#     When a large population is sampled
#     Then height and weight should be 30 percent correlated
#      And the empirical rule should apply to normally distributed features
#
#  Scenario: multiple features with covariance matrix
#    Given a feature height with mean 80 and standard deviation 25
#      And a feature weight with mean 150 and standard deviation 30
#      And a feature foot_size with mean 10 and standard deviation 3
#      And height and weight are strongly correlated
#      And weight and foot_size are weakly correlated
#      And height and foot_size are 90 percent correlated
#     When a large population is sampled
#     Then height and weight should be strongly correlated
#      And weight and foot_size should be weakly correlated
#      And height and foot_size should be 90 percent correlated
#      And the empirical rule should apply to normally distributed features

#      And at least 68 percent of sampled foot_size should be within 3 of 10
#      And at least 95 percent of sampled foot_size should be within 6 of 10
#      And at least 68 percent of sampled height should be within 25 of 80
#      And at least 95 percent of sampled height should be within 50 of 80
#      And at least 68 percent of sampled weight should be within 30 of 150
#      And at least 95 percent of sampled weight should be within 60 of 150

#  Scenario: subpopulation handling
#    Given a subpopulation men
#      And men always have gender 'male'


  # Scenario: subpopulations (e.g.: males have one distribution, females another)
  # Given ...


#  Scenario: generating people
#    Given a feature 'hair' with the following values:
#      | blond  |
#      | brown  |
#      | red    |
#    And a feature 'gender' with the following values:
#      | male   |
#      | female |
#    When the population is sampled
#    Then I should see the following features:
#       |    hair   | gender |
#       |    red    | female |
#       |   blond   |  male  |
