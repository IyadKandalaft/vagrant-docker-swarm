require 'fileutils'
require 'yaml'

module Config
  # Load a configuration file or create one from the sample
  def Config.load(custom_conf_path, sample_conf_path)
    # Load the customized configuration file
    # Otherwise, copy the sample over and load it
    if not File.file?(custom_conf_path) then
      if File.file?(sample_conf_path) then
        FileUtils.cp(sample_conf_path, custom_conf_path)
      else
        raise "Cannot find the sample configuration file %s" % [sample_conf_path]
      end
    end
  
    config = YAML::load_file(custom_conf_path)
    return config
  end
end
