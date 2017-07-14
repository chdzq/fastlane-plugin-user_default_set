module Fastlane
  module Actions
    class UserDefaultSetAction < Action
      def self.run(params)
        require 'json'
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        path = params[:path]

        map = Hash.new
        isExist = File.exist? path
        if isExist
          json_string = File.read(path)
          json = JSON.parse(json_string)
          map = json if json.is_a? Hash
        end
        key = params[:key]
        value = params[:value]
        if value.nil?
          map.delete(key)
        else
          map[key] = value
        end
        if isExist
          File.open(path, "w+") do |file|
            file.puts(map.to_json)
          end
        else
          dirname = File.dirname(path)
          unless File.directory?(dirname)
            FileUtils.mkdir_p(dirname)
          end
          file = File.new(path, "w+")
          file.puts(map.to_json)
          file.close
        end
      end

      def self.description
        "fastlane save user default like ios userDefault"
      end

      def self.authors
        ["zhangqi"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "use like as UserDefault"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "USER_DEFAULT_SET_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "user_default_path_save", # The name of the environment variable
                                       description: "Path for UserDefault", # a short description of this parameter
                                       default_value: "build/.configure.fastlane",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :key,
                                       env_name: "user_default_key_save",
                                       description: "key for user default",
                                       is_string: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("No key for UserDefaultSetAction , pass using `key: 'key'`") unless (value and not value.empty?)
                                         # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :value,
                                       env_name: "user_default_value",
                                       description: "value for user default",
                                       optional: true,
                                       is_string: true,
                                       default_value: nil)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        [:ios, :mac, :android].include?(platform)
      end
    end
  end
end
