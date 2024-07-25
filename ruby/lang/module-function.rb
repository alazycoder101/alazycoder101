module ModuleFunction
  extend self

  def who_am_i
    "ModuleFunction"
  end
end

ModuleFunction.who_am_i # => "ModuleFunction"

module ModuleFunction
  def who_am_i
    "overridden ModuleFunction"
  end
end

ModuleFunction.who_am_i # => "overridden ModuleFunction"
