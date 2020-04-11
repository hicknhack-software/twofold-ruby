module Twofold

  # Base class for Filters used in Twofold
  #
  # Add all recursive S-Expressions!
  #
  # @api private
  class Filter < Temple::Filter

    # Pass-through handler
    def on_twofold_indented(indent, inner)
      [:twofold, :indented, indent, compile(inner)]
    end

  end

end