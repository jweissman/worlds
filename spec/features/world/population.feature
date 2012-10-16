Feature: generate random populations
  In order to easily create complex sets
  A world creator should be able to generate random populations

  Scenario: one feature with one value
    Given a feature species with the following values:
      | human |
    When the population is sampled
    Then I should see the following individuals
      | species |
      |  human  |

  Scenario: one feature with two values
    Given a feature species with the following values:
      | human |
      | alien |
    When the population is sampled
    Then I should see the following individuals
      | species |
      |  human  |
      |  alien  |

  Scenario: several features with several values
    Given a feature gender with the following values:
      | male   |
      | female |
      | other  |
    And a feature species with the following values:
      | human   |
      | alien   |
      | machine |
    And a feature profession with the following values:
      | merchant |
      | priest   |
      | soldier  |
      | pilot    |
    When a large population is sampled
    Then I should see the following individuals
      | species | gender | profession |
      |  human  |  male  |  soldier   |
      |  alien  | female |  merchant  |
      | machine |  other |  priest    |

  # scalar features
  # scalar features with multiple values
  # relationships between features

  Scenario: scalar features
   Given a feature height with mean 70 and standard deviation 30
    When the population is sampled
    Then average sampled height should be within 15 of 70
     And 90 percent of sampled height should be within 25 of 70

  Scenario: weakly-correlated scalar feature pair
    Given a feature height with mean 80 and standard deviation 40
    And a feature weight with mean 150 and standard deviation 30
    And height and weight are weakly correlated
    When a large population is sampled
    Then height and weight should be weakly correlated

  Scenario: strongly-correlated scalar feature pair
    Given a feature height with mean 80 and standard deviation 40
      And a feature weight with mean 150 and standard deviation 30
      And height and weight are strongly correlated
     When a large population is sampled
     Then height and weight should be strongly correlated

  Scenario: arbitrarily-correlated scalar feature pair
    Given a feature height with mean 80 and standard deviation 45
      And a feature weight with mean 160 and standard deviation 50
      And height and weight are 30 percent correlated
     When a large population is sampled
     Then height and weight should be 30 percent correlated

#  Scenario: random vectors with covariance


  Scenario: random vectors with covariance
    Given a feature height with mean 80 and standard deviation 25
      And a feature weight with mean 150 and standard deviation 30
      And a feature foot_size with mean 10 and standard deviation 3
      And height and weight are strongly correlated
      And weight and foot_size are weakly correlated
      And height and foot_size are 90 percent correlated
     When a large population is sampled
     Then height and weight should be strongly correlated
      And weight and foot_size should be weakly correlated
      And height and foot_size should be 90 percent correlated


#      And the following covariance matrix:
#        |           | height | weight | foot_size |
#        | height    |        |        |           |
#        | weight    |        |        |           |
#        | foot_size |        |        |           |



#  Scenario: several correlated scalar features
#    Given a feature 'height' with mean 80 and standard deviation

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
