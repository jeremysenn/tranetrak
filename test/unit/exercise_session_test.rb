require 'test_helper'

class ExerciseSessionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ExerciseSession.new.valid?
  end
end
