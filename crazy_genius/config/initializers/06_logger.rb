# frozen_string_literal: true

require 'logger'

STDOUT.sync = true

logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG
logger.progname = $PROGRAM_NAME
logger.formatter = proc do |severity, time, progname, message|
  "[#{progname}] [#{time.strftime('%F %T')}] #{severity.upcase}: #{message}\n"
end

Crazy::Init.configure do |settings|
  settings.set :logger, logger
end
