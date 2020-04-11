module Twofold
  class Engine < Temple::Engine
    use Twofold::Parser

    use Twofold::Interpolation
    use Twofold::Indentation

    filter :ControlFlow
    filter :MultiFlattener
    filter :StaticMerger

    generator :ArrayBuffer, buffer: "@_buf" # we use buffer attribute so custom methods can use it too
  end
end