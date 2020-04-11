require 'temple'
require 'twofold/version'

module Twofold
  autoload :Engine, 'twofold/engine'
  autoload :Parser, 'twofold/parser'
  autoload :Template, 'twofold/template'
  autoload :Filter, 'twofold/filter'
  autoload :Interpolation, 'twofold/interpolation'
  autoload :Indentation, 'twofold/indentation'
end
