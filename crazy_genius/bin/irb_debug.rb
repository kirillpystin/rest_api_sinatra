# frozen_string_literal: true

require 'irb'
require 'irb/completion'

begin
  require_relative '../spec/spec_helper'
rescue LoadError
  nil
end

begin
  require 'awesome_print'
rescue LoadError
  nil
end

IRB.start
