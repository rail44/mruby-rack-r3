MRuby::Gem::Specification.new('mruby-rack-r3') do |spec|
  spec.license = 'MIT'
  spec.authors = 'AMEMIYA Satoshi'
  spec.summary = 'Rack app with R3 router'

  spec.add_dependency "mruby-r3", git: 'git://github.com/rail44/mruby-r3.git'
end
