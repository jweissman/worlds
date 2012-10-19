Feature: generate pseudorandom categorical attributes
  in order to quickly create complex domains
  a world creator should be able to create populations with pseudorandom categorical attributes

  Scenario: one feature with one value
    Given a feature "species" with the following values:
      | human |
    When the population is sampled
    Then I should see the following individuals:
      | species |
      |  human  |

  Scenario: one feature with two values
    Given a feature "species" with the following values:
      | human |
      | alien |
    When the population is sampled
    Then I should see the following individuals:
      | species |
      |  human  |
      |  alien  |

  Scenario: several features with several values
    Given a feature "gender" with the following values:
      | male   |
      | female |
      | other  |
    And a feature "species" with the following values:
      | human   |
      | alien   |
      | machine |
    And a feature "profession" with the following values:
      | merchant |
      | priest   |
      | soldier  |
      | pilot    |
    When a large population is sampled
    Then I should see the following individuals:
      | species | gender | profession |
      |  human  |  male  |  soldier   |
      |  alien  | female |  merchant  |
      | machine |  other |  priest    |
