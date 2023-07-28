# frozen_string_literal: true

#
# Helper module to suport common cases for the tests. Like disabling callbacks, etc.
#
module CommonExtension
  #
  # Method disable callbacks for a model during a block executing.
  #
  # @param klass [<ApplicationRecord>] Model's class for which a callback should be disabled
  # @param *args [<Arrey>] the list of arguments for the regular ActiveSupport#skip_callback method
  # @param &block [Block] the block to be executed without a callback
  #
  # @return [<any>] a result of calling a block
  #
  def disable_callback_for(klass, *args)
    klass.skip_callback(*args)
    result = yield
    klass.set_callback(*args)
    result
  end
end
