require 'execjs'
require 'typescript/source'

module TypeScript
  EngineError      = ExecJS::RuntimeError
  CompilationError = ExecJS::ProgramError

  module Source
    def self.path
      @path ||= ENV['TYPESCRIPT_SOURCE_PATH'] || bundled_path
    end

    def self.compiler_path
      @compiler_path ||= ENV['TYPESCRIPT_COMPILER_PATH'] || compiler_bundled_path
    end

    def self.lib_path
      @lib_path ||= ENV['TYPESCRIPT_LIB_PATH'] || lib_bundled_path
    end

    def self.path=(path)
      @contents = @version = @bare_option = @context = nil
      @path = path
    end

    def self.contents
      @contents ||= "#{File.read(path)}\n#{File.read(compiler_path)}"
    end

    def self.lib_contents
      @lib_contents ||= File.read(lib_path)
    end

    def self.version
      @version ||= '0.8.0'
    end

    def self.bare_option
      @bare_option ||= 'bare'
    end

    def self.context
      @context ||= ExecJS.compile(contents)
    end
  end

  class << self
    def engine
    end

    def engine=(engine)
    end

    def version
      Source.version
    end

    # Compile a script (String or IO) to JavaScript.
    def compile(script, options = {})
      script = script.read if script.respond_to?(:read)

      if options.key?(:bare)
      elsif options.key?(:no_wrap)
        options[:bare] = options[:no_wrap]
      else
        options[:bare] = false
      end

      Source.context.call("RubyTypeScriptCompiler", Source.lib_contents, script, options)
    end
  end
end
