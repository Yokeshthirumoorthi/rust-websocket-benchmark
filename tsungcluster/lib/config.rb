## Copyright © 2018 Yokesh Thirumoorthi
## [This program is licensed under the "MIT License"]
## Please see the file LICENSE in the source
## distribution of this software for license terms.

## CREDITS
## Project: https://github.com/dsander/phoenix-connection-benchmark

require 'yaml'

class Config
  class << self
    def method_missing(key)
      config.send(key)
    end

    private

    def config
      @config ||= begin
        hash = YAML.load(File.read('config.yml'))
        to_ostruct(hash)
      end
    end

    def to_ostruct(value)
      if value.is_a?(Hash)
        OpenStruct.new(Hash[value.map { |key, value| [key, to_ostruct(value)]}])
      else
        value
      end
    end
  end
end
