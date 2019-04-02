# frozen_string_literal: true

Dir["#{Crazy.path}/lib/crazy/actions**/*.rb"].each(&method(:require))
