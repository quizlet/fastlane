module Frameit
  class Offsets
    def self.device_top_padding_ratio(screenshot)
      size = Deliver::AppScreenshot::ScreenSize
      case screenshot.screen_size
        when size::IOS_55, size::ANDROID_NEXUS_5X, size::ANDROID_NEXUS_7, size::ANDROID_NEXUS_10
          return 0.2
        when size::IOS_47
          return 0.2
        when size::IOS_40
          return 0.25
        when size::IOS_35
          return 0.28
        when size::IOS_IPAD
          return 0.2
        when size::IOS_IPAD_PRO
          return 0.15
      end
    end

    def self.title_font_size(screenshot)
      size = Deliver::AppScreenshot::ScreenSize
      case screenshot.screen_size
      when size::IOS_55, size::ANDROID_NEXUS_5X
        return 60
      when size::IOS_47
        return 56
      when size::IOS_40
        return 56
      when size::IOS_35
        return 52
      when size::IOS_IPAD
        return 56
      when size::IOS_IPAD_PRO
        return 64
      when size::ANDROID_NEXUS_7
        return 56
      when size::ANDROID_NEXUS_10
        return 72
      end
    end

    # Returns the image offset needed for a certain device type for a given orientation
    # uses deliver to detect the screen size
    # rubocop:disable Metrics/MethodLength
    def self.image_offset(screenshot)
      size = Deliver::AppScreenshot::ScreenSize
      case screenshot.orientation_name
      when Orientation::PORTRAIT
        case screenshot.screen_size
        when size::IOS_55, size::ANDROID_NEXUS_5X
          return {
            'offset' => '+41+146',
            'width' => 541
          }
        when size::IOS_47
          return {
            'offset' => "+43+154",
            'width' => 530
          }
        when size::IOS_40
          return {
            'offset' => "+54+197",
            'width' => 544
          }
        when size::IOS_35
          return {
            'offset' => "+59+260",
            'width' => 647
          }
        when size::IOS_IPAD
          return {
            'offset' => '+47+135',
            'width' => 737
          }
        when size::IOS_IPAD_PRO
          return {
            'offset' => '+48+90',
            'width' => 805
          }
        when size::ANDROID_NEXUS_7, size::ANDROID_NEXUS_10
          return {
            'offset' => '+47+135',
            'width' => 737
          }
        end
      when Orientation::LANDSCAPE
        case screenshot.screen_size
        when size::IOS_55, size::ANDROID_NEXUS_5X
          return {
            'offset' => "+146+41",
            'width' => 960
          }
        when size::IOS_47
          return {
            'offset' => "+153+41",
            'width' => 946
          }
        when size::IOS_40
          return {
            'offset' => "+201+48",
            'width' => 970
          }
        when size::IOS_35
          return {
            'offset' => "+258+52",
            'width' => 966
          }
        when size::IOS_IPAD
          return {
            'offset' => '+135+47',
            'width' => 983
          }
        when size::IOS_IPAD_PRO
          return {
            'offset' => '+88+48',
            'width' => 1075
          }
        when size::ANDROID_NEXUS_7, size::ANDROID_NEXUS_10
          return {
            'offset' => '+135+47',
            'width' => 983
          }
        end
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end