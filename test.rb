module Foo
  module OtherModule
    ReadMe = "text"
  end
  def self.included(base)
    super
    base.class_exec do
      include Foo::OtherModule
    end
  end
end

class TheClass
  include Foo
  def initialize
    puts ReadMe # => raises missing constant error
    puts self.class::ReadMe # => is fine
  end
end

TheClass.new