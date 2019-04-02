# frozen_string_literal: true

Dir["#{Crazy.path}/lib/crazy/models/**/*.rb"].each(&method(:require))
