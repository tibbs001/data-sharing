module Proj
  class Publication < ActiveRecord::Base
    belongs_to :project

  end
end

