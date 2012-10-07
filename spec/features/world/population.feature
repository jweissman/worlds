Feature: generate random populations
  In order to easily create complex sets
  A world creator should be able to generate random populations

  Scenario: one feature with one value
    Given a feature 'species' with the following values:
      | human |
    When the population is sampled
    Then I should see the following individuals
      | species |
      |  human  |

  Scenario: one feature with two values
    Given a feature 'species' with the following values:
      | human |
      | alien |
    When the population is sampled
    Then I should see the following individuals
      | species |
      |  human  |
      |  alien  |

  Scenario: several features with several values
    Given a feature 'gender' with the following values:
      | male   |
      | female |
      | other  |
    And a feature 'species' with the following values:
      | human   |
      | alien   |
      | machine |
    And a feature 'profession' with the following values:
      | merchant |
      | priest   |
      | soldier  |
      | pilot    |
    When a population of 30000 is sampled
    Then I should see the following individuals
      | species | gender | profession |
      |  human  |  male  |  soldier   |
      |  alien  | female |  merchant  |
      | machine |  other |  priest    |

  # scalar features
  # scalar features with multiple values
  # relationships between features

#  Scenario: scalar features
#    Given a feature 'height' with mean 70 and variance 25
 #    And a feature 'weight' (mean 160, variance 50) with an 80% correlation to 'height'
#    When the population is sampled
#    Then I should see individuals like









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
