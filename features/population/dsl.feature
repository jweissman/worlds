#Feature: use a DSL to creation pseudorandom populations
#  In order to simple simulation of complex domains
#  As an a world creator
#  I want to gain easily create complicated populations
#
#  Scenario: a simple population
#    Given a file "simple_population.world" with contents:
#      """
#      class SimplePopulation < Worlds::Population::Base
#        subpopulation :men, :women do
#          shared_features :height, :weight, :foot_size
#          strongly_correlate :height, :weight
#          strongly_correlate :weight, :foot_size
#          weakly_correlate :height, :foot_size
#
#          men do
#            gender 'male'
#            height mean: 80, standard_deviation: 25
#            weight mean: 50, standard_deviation: 30
#            foot_size mean: 13, standard_deviation: 5
#          end
#
#          women do
#            gender 'female'
#            height mean: 75, standard_deviation: 16
#            weight mean: 60, standard_deviation: 25
#            foot_size mean: 12, standard_deviation: 4
#          end
#        end
#      end
#      """
#    When I run `worlds sample simple_population`
#    Then the population notes should contain:
#      """
#      = Population with subpopulations
#        = Men and women
#          = Shared features
#           - Height
#           - Weight
#           - Foot size
#           - Gender
#          = Notes
#           - Height and weight are strongly-correlated
#           - Weight and foot size are strongly-correlated
#           - Height and foot size are weakly-correlated
#          = Men
#            - Gender is "male"
#            - Height is normal (with mean 80, standard deviation 10)
#            - Weight is normal (with mean 150, standard deviation 15)
#            - Foot size is normal (with mean 15, standard deviation 5)
#          = Women
#            - Gender is "female"
#            - Height is normal (with mean 75, standard deviation 16)
#            - Weight is normal (with mean 90, standard deviation 25)
#            - Foot size is normal (with mean 15, standard deviation 5)
#      """
#    And the empirical rule should hold for the sampled population data
#
#  Scenario: a more complicated population
#      Given a file "complicated_population.world" with contents:
#      """
#      class SimplePopulation < Worlds::Population::Base
#        subpopulation :men, :women do
#          shared_features :height, :weight, :foot_size
#          strongly_correlate :height, :weight
#          strongly_correlate :weight, :foot_size
#          weakly_correlate :height, :foot_size
#
#          men do
#            gender 'male'
#            height mean: 80, standard_deviation: 25
#            weight mean: 50, standard_deviation: 30
#            foot_size mean: 13, standard_deviation: 5
#          end
#
#          women do
#            gender 'female'
#            height mean: 75, standard_deviation: 16
#            weight mean: 60, standard_deviation: 25
#            foot_size mean: 12, standard_deviation: 4
#          end
#        end
#      end
#      """
