module Messenger
  class Engine < ::Rails::Engine
    isolate_namespace Messenger

    root = Messenger.root.to_s

    config.autoload_paths += %W(#{root}/lib)

    initializer :append_view_paths do |app|
      ActiveSupport.on_load :action_controller do
        append_view_path File.join(root, 'app/views')
      end
    end
  end
end
