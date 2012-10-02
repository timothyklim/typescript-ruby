Gem::Specification.new do |s|
  s.name      = 'typescript'
  s.version   = '0.1'
  s.date      = '2012-10-03'

  s.homepage    = "https://github.com/TimothyKlim/typescript-ruby"
  s.summary     = "Ruby TypeScript Compiler"
  s.description = <<-EOS
    Ruby TypeScript is a bridge to the JS TypeScript compiler.
  EOS

  s.files = [
    'lib/typescript.rb',
    'LICENSE',
#    'README.md'
  ]

  s.add_dependency 'typescript-source'
  s.add_dependency 'execjs'

  s.authors = ['TimothyKlim']
  s.email   = 'klimtimothy@gmail.com'
end
