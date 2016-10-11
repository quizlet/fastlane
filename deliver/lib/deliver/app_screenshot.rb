require 'fastimage'

module Deliver
  # AppScreenshot represents one screenshots for one specific locale and
  # device type.
  class AppScreenshot
    module ScreenSize
      # iPhone 4
      IOS_35 = "iOS-3.5-in"
      # iPhone 5
      IOS_40 = "iOS-4-in"
      # iPhone 6
      IOS_47 = "iOS-4.7-in"
      # iPhone 6 Plus
      IOS_55 = "iOS-5.5-in"
      # iPad
      IOS_IPAD = "iOS-iPad"
      # iPad Pro
      IOS_IPAD_PRO = "iOS-iPad-Pro"
      # iPhone 5 iMessage
      IOS_40_MESSAGES = "iOS-4-in-messages"
      # iPhone 6 iMessage
      IOS_47_MESSAGES = "iOS-4.7-in-messages"
      # iPhone 6 Plus iMessage
      IOS_55_MESSAGES = "iOS-5.5-in-messages"
      # iPad iMessage
      IOS_IPAD_MESSAGES = "iOS-iPad-messages"
      # iPad Pro iMessage
      IOS_IPAD_PRO_MESSAGES = "iOS-iPad-Pro-messages"
      # Apple Watch
      IOS_APPLE_WATCH = "iOS-Apple-Watch"
      # Mac
      MAC = "Mac"
      # Apple TV
      APPLE_TV = "Apple-TV"
      # Android Nexus 5X
      ANDROID_NEXUS_5X = "Android-Nexus-5X"
      # Android Nexus 7
      ANDROID_NEXUS_7 = "Android-Nexus-7"
      #Android Nexus 10
      ANDROID_NEXUS_10 = "Android-Nexus-10"
    end

    module Platform
      # Apple (iOS, Mac, Apple TV)
      APPLE = "Apple"
      # Android
      ANDROID = "Android"
    end

    # @return [Deliver::ScreenSize] the screen size (device type)
    #  specified at {Deliver::ScreenSize}
    attr_accessor :screen_size

    attr_accessor :path

    attr_accessor :language

    # @param path (String) path to the screenshot file
    # @param path (String) Language of this screenshot (e.g. English)
    # @param screen_size (Deliver::AppScreenshot::ScreenSize) the screen size, which
    #  will automatically be calculated when you don't set it.
    def initialize(path, language, screen_size = nil)
      self.path = path
      self.language = language
      screen_size ||= self.class.calculate_screen_size(path)

      self.screen_size = screen_size

      UI.error("Looks like the screenshot given (#{path}) does not match the requirements of #{screen_size}") unless self.is_valid?
    end

    # The iTC API requires a different notation for the device
    def device_type
      matching = {
        ScreenSize::IOS_35 => "iphone35",
        ScreenSize::IOS_40 => "iphone4",
        ScreenSize::IOS_47 => "iphone6",
        ScreenSize::IOS_55 => "iphone6Plus",
        ScreenSize::IOS_IPAD => "ipad",
        ScreenSize::IOS_IPAD_PRO => "ipadPro",
        ScreenSize::IOS_40_MESSAGES => "iphone4",
        ScreenSize::IOS_47_MESSAGES => "iphone6",
        ScreenSize::IOS_55_MESSAGES => "iphone6Plus",
        ScreenSize::IOS_IPAD_MESSAGES => "ipad",
        ScreenSize::IOS_IPAD_PRO_MESSAGES => "ipadPro",
        ScreenSize::MAC => "desktop",
        ScreenSize::IOS_APPLE_WATCH => "watch",
        ScreenSize::APPLE_TV => "appleTV",
        ScreenSize::ANDROID_NEXUS_5X => "androidNexus5X",
        ScreenSize::ANDROID_NEXUS_7 => "androidNexus7",
        ScreenSize::ANDROID_NEXUS_10 => "androidNexus10"
      }
      return matching[self.screen_size]
    end

    # Nice name
    def formatted_name
      matching = {
        ScreenSize::IOS_35 => "iPhone 4",
        ScreenSize::IOS_40 => "iPhone 5",
        ScreenSize::IOS_47 => "iPhone 6",
        ScreenSize::IOS_55 => "iPhone 6 Plus",
        ScreenSize::IOS_IPAD => "iPad",
        ScreenSize::IOS_IPAD_PRO => "iPad Pro",
        ScreenSize::IOS_40_MESSAGES => "iPhone 5 (iMessage)",
        ScreenSize::IOS_47_MESSAGES => "iPhone 6 (iMessage)",
        ScreenSize::IOS_55_MESSAGES => "iPhone 6 Plus (iMessage)",
        ScreenSize::IOS_IPAD_MESSAGES => "iPad (iMessage)",
        ScreenSize::IOS_IPAD_PRO_MESSAGES => "iPad Pro (iMessage)",
        ScreenSize::MAC => "Mac",
        ScreenSize::IOS_APPLE_WATCH => "Watch",
        ScreenSize::APPLE_TV => "Apple TV",
        # Android.
        ScreenSize::ANDROID_NEXUS_5X => "Android Nexus 5X",
        ScreenSize::ANDROID_NEXUS_7 => "Android Nexus 7",
        ScreenSize::ANDROID_NEXUS_10 => "Android Nexus 10"
      }
      return matching[self.screen_size]
    end

    # Validates the given screenshots (size and format)
    def is_valid?
      return false unless ["png", "PNG", "jpg", "JPG", "jpeg", "JPEG"].include?(self.path.split(".").last)

      return self.screen_size == self.class.calculate_screen_size(self.path)
    end

    def self.apple_devices
      return {
        ScreenSize::IOS_55 => [
          [1080, 1920],
          [1242, 2208]
        ],
        ScreenSize::IOS_47 => [
          [750, 1334]
        ],
        ScreenSize::IOS_40 => [
          [640, 1136],
          [640, 1096],
          [1136, 600] # landscape status bar is smaller
        ],
        ScreenSize::IOS_35 => [
          [640, 960],
          [640, 920],
          [960, 600] # landscape status bar is smaller
        ],
        ScreenSize::IOS_IPAD => [
          [1024, 748],
          [1024, 768],
          [2048, 1496],
          [2048, 1536],
          [768, 1004],
          [768, 1024],
          [1536, 2008],
          [1536, 2048]
        ],
        ScreenSize::IOS_IPAD_PRO => [
          [2732, 2048],
          [2048, 2732]
        ],
        ScreenSize::MAC => [
          [1280, 800],
          [1440, 900],
          [2880, 1800],
          [2560, 1600]
        ],
        ScreenSize::IOS_APPLE_WATCH => [
          [312, 390]
        ],
        ScreenSize::APPLE_TV => [
          [1920, 1080]
        ]
      }
    end

    def self.android_devices
      return {
        ScreenSize::ANDROID_NEXUS_5X => [
          [1080, 1920]
        ],
        # Older devices.
        ScreenSize::ANDROID_NEXUS_7 => [
          [1200, 1920]
        ],
        ScreenSize::ANDROID_NEXUS_10 => [
          [2560, 1600]
        ]
      }
    end

    def self.devices_for_lookup(platform)
      platforms = Platform
      case platform
      when platforms::APPLE
        return self.apple_devices
      when platforms::ANDROID
        return self.android_devices
      else
        UI.error "Unknown device type for size #{@screen_size} for path '#{path}' and platform #{platform}"
      end
    end

    def self.calculate_screen_size(path, platform=Platform::APPLE)
      size = FastImage.size(path)

      UI.user_error!("Could not find or parse file at path '#{path}'") if size.nil? or size.count == 0

      # Walk up two directories and test if we need to handle a platform that doesn't support landscape
      path_component = Pathname.new(path).each_filename.to_a[-3]
      if path_component.eql? "appleTV"
        skip_landscape = true
      end

      devices = self.devices_for_lookup(platform)

      devices.each do |device_type, array|
        array.each do |resolution|
          if skip_landscape
            if size[0] == resolution[0] and size[1] == resolution[1] # portrait
              return device_type
            end
          else
            if (size[0] == resolution[0] and size[1] == resolution[1]) or # portrait
               (size[1] == resolution[0] and size[0] == resolution[1]) # landscape
              return device_type
            end
          end
        end
      end

      UI.user_error!("Unsupported screen size #{size} for path '#{path}'")
    end
  end

  ScreenSize = AppScreenshot::ScreenSize
end
