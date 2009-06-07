### gemspec: open4-1.0.0

  Gem::Specification::new do |spec|
    spec.name = "open4"
    spec.version = "1.0.0"
    spec.platform = Gem::Platform::RUBY
    spec.summary = "open4"

    spec.files = ["gemspec.rb", "install.rb", "lib", "lib/open4.rb", "open4.gemspec", "README", "samples", "samples/bg.rb", "samples/block.rb", "samples/exception.rb", "samples/simple.rb", "samples/spawn.rb", "samples/stdin_timeout.rb", "samples/timeout.rb", "white_box", "white_box/leak.rb"]
    spec.executables = []
    
    spec.require_path = "lib"

    spec.has_rdoc = true
    spec.test_files = nil
    #spec.add_dependency 'lib', '>= version'
    #spec.add_dependency 'fattr'

    spec.extensions.push(*[])

    spec.rubyforge_project = 'codeforpeople'
    spec.author = "Ara T. Howard"
    spec.email = "ara.t.howard@gmail.com"
    spec.homepage = "http://github.com/ahoward/open4/tree/master"
  end

