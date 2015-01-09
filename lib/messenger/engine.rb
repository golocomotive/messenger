module Messenger
  class Engine < ::Rails::Engine
    isolate_namespace Messenger
    config.autoload_paths += %W(#{root}/lib)
  end
end
