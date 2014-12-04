class ConcernsGenerator < Rails::Generators::NamedBase
  ACTIVE_RECORD_FILES = %w(
    active_record
    class_methods
    extensions
    instance_methods
    search
    scopes )

  argument :files,   type: :array, default: ACTIVE_RECORD_FILES, banner: 'suffix suffix ...'

  source_root File.expand_path('../templates', __FILE__)

  attr_accessor :simple_class_path

  def create_concerns_files
    @simple_class_path = class_path.first

    invoke :model

    empty_directory "app/models/#{simple_class_path}/#{klass}"
    empty_directory "spec/models/#{simple_class_path}/#{klass}"

    inject_into_class "app/models/#{simple_class_path}/#{klass}.rb", klass.classify, verbose: true do
      "  concerned_with(\n    " +
          (files).map { |file| ":#{name.underscore}_#{file}" }.join(",\n    ") + " )\n"
    end

    files.each do |file|
      template 'empty_class.rb', "app/models/#{simple_class_path}/#{klass}/#{klass}_#{file}.rb"
      template 'empty_spec.rb',  "spec/models/#{simple_class_path}/#{klass}/#{klass}_#{file}_spec.rb"
    end
  end

  private

    def klass
      @klass ||= name.to_s.underscore
    end
end
