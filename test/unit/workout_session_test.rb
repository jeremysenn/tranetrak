require 'test_helper'

class WorkoutSessionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert WorkoutSession.new.valid?
  end
end
