#Feature: handle complex inter-related subpopulations
#  In order to provide realistic virtual worlds
#  As a world creators
#  I want to gain the ability to generate populations with complex inter-relationships
#
#  Scenario: generating a population with a simple binary subpopulation
#    Given a population with the following attributes:
#      | gender    |
#      | height    |
#      | weight    |
#      | foot size |
#     And "height" and "weight" are strongly correlated
#     And "height" and "foot size" are strongly correlated
#     And "weight" and "foot size" are weakly correlated
#     And a binary subpopulation "gender" divided into "males" and "females"
#     And "males" are approximately 48% of the total population
#
#     And "males" have normally-distributed "height" with mean 40, standard deviation 25)
#     And "males" have normally-distributed "weight" with mean 40, standard deviation 25)
#     And "males" have normally-distributed "foot size" with mean 40, standard deviation 25)
#
#     And "females" have normally-distributed "height" with mean 40, standard deviation 25)
#     And "females" have normally-distributed "weight" with mean 40, standard deviation 25)
#     And "females" have normally-distributed "foot size" with mean 40, standard deviation 25)
#
#    When a large population is sampled
#    Then the empirical rule should hold
#     And the empirical rule should hold for all subpopulations
#     And "height" and "weight" should be strongly correlated
#     And "height" and "foot size" should be strongly correlated
#     And "weight" and "foot size" should be weakly correlated
#
# Scenario: generation a population with multiple overlapping subpopulations with arbitrary modal arities
#   Given a population with the following attributes:
#     | gender       |
#     | height       |
#     | weight       |
#     | foot size    |
#     | strength     |
#     | agility      |
#     | intelligence |
#     | charisma     |
#   And "height" and "weight" are strongly correlated
#   And "height" and "foot size" are strongly correlated
#   And "weight" and "foot size" are weakly correlated
#   And "height" and "charisma" are weakly correlated
#   And "intelligence" and "charisma" are strongly correlated
#   And "strength" and "agility" are weakly correlated
#
#   And a binary subpopulation "gender" divided into "males" and "females"
#   And "males" are 48% of the total population
#   And "males" have normally-distributed "height" with mean 40 and standard deviation 25
#   And "males" have normally-distributed "weight" with mean 40 and standard deviation 25
#   And "males" have normally-distributed "foot size" with mean 40 and standard deviation 25
#   And "females" have normally-distributed "height" with mean 40 and standard deviation 25
#   And "females" have normally-distributed "weight" with mean 40 and standard deviation 25
#   And "females" have normally-distributed "foot size" with mean 40 and standard deviation 25
#
#   Given a complex subpopulation "profession" divided into the following groups:
#      |  medics   |
#      |  pilots   |
#      |  gunners  |
#      |  officers |
#
#   And "medics" are 20% of the total population
#   And "medics" have normally-distributed "strength" with mean 7 and standard deviation 5
#   And "medics" have normally-distributed "agility" with mean 7 and standard deviation 5
#   And "medics" have normally-distributed "intelligence" with mean 7 and standard deviation 25
#   And "medics" have normally-distributed "charisma" with mean 7 and standard deviation 25
#
#   And "pilots" are 28% of the total population
#   And "pilots" have normally-distributed "strength" with mean 7 and standard deviation 5
#   And "pilots" have normally-distributed "agility" with mean 7 and standard deviation 5
#   And "pilots" have normally-distributed "intelligence" with mean 7 and standard deviation 25
#   And "pilots" have normally-distributed "charisma" with mean 7 and standard deviation 25
#
#   And "gunners" are 23% of the total population
#   And "gunners" have normally-distributed "strength" with mean 7 and standard deviation 5
#   And "gunners" have normally-distributed "agility" with mean 7 and standard deviation 5
#   And "gunners" have normally-distributed "intelligence" with mean 7 and standard deviation 25
#   And "gunners" have normally-distributed "charisma" with mean 7 and standard deviation 25
#
#   And "pilots" have normally-distributed "strength" with mean 7 and standard deviation 5
#   And "pilots" have normally-distributed "agility" with mean 7 and standard deviation 5
#   And "pilots" have normally-distributed "intelligence" with mean 7 and standard deviation 25
#   And "pilots" have normally-distributed "charisma" with mean 7 and standard deviation 25
#
#   When a large population is sampled
#   Then the empirical rule should hold
#   And the empirical rule should hold for all subpopulations
#   And "height" and "weight" should be strongly correlated
#   And "height" and "foot size" should be strongly correlated
#   And "weight" and "foot size" should be weakly correlated
#   And "height" and "charisma" should be weakly correlated
#   And "intelligence" and "charisma" should be strongly correlated
#   And "strength" and "agility" should be weakly correlated
#
