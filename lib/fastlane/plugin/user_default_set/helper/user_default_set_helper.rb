module Fastlane
  module Helper
    class UserDefaultSetHelper
      # class methods that you define here become available in your action
      # as `Helper::UserDefaultSetHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the user_default_set plugin helper!")
      end
    end
  end
end
