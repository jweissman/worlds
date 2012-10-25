require "matrix"

##########

require "worlds/version"

require "worlds/ext/array"
require "worlds/ext/matrix"

require "worlds/helpers/random_gaussian"
require "worlds/helpers/pearson"
require "worlds/helpers/cholesky"

require "worlds/attribute/base"
require "worlds/attribute/constant_attribute"
require "worlds/attribute/categorical_attribute"
require "worlds/attribute/correlated_attribute_vector"
require "worlds/attribute/normally_distributed_attribute"

require "worlds/population/base"

module Worlds
  # some global constants
  DEFAULT_SAMPLE_SIZE = 30
  LARGE_SAMPLE_SIZE   = 300000

  STRONG_CORRELATION  = 0.8
  WEAK_CORRELATION    = 0.5

  # default error tolerance is 0.5%
  # note we will in certain cases make a percent error calculation
  # to see if we were within a given percentage of desired target
  # (also sometimes used as a fallback measure if a 'strict' assertion fails)
  DEFAULT_TOLERANCE   = 0.005

  # helpers/dsl here?
end
