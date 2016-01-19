module Browser
  class Platform
    include DetectVersion

    attr_reader :ua

    def initialize(ua)
      @ua = ua
    end

    def subject
      @subject ||= [
        AdobeAir.new(ua),
        ChromeOS.new(ua),
        WindowsMobile.new(ua),
        WindowsPhone.new(ua),
        Android.new(ua),
        BlackBerry.new(ua),
        IOS.new(ua),
        Mac.new(ua),
        FirefoxOS.new(ua),
        Windows.new(ua),
        Linux.new(ua),
        Other.new(ua)
      ].find(&:match?)
    end

    def adobe_air?
      id == :adobe_air
    end

    def chrome_os?
      id == :chrome_os
    end

    def android?(expected_version = nil)
      id == :android && detect_version?(version, expected_version)
    end

    def other?
      id == :other
    end

    def linux?
      id == :linux
    end

    def mac?
      id == :mac
    end

    def windows?
      id == :windows
    end

    def firefox_os?
      id == :firefox_os
    end

    def ios?(expected_version = nil)
      id == :ios && detect_version?(version, expected_version)
    end

    def blackberry?(expected_version = nil)
      id == :blackberry && detect_version?(version, expected_version)
    end

    def windows_phone?(expected_version = nil)
      id == :windows_phone && detect_version?(version, expected_version)
    end

    def windows_mobile?(expected_version = nil)
      id == :windows_mobile && detect_version?(version, expected_version)
    end

    def id
      subject.id
    end

    def version
      subject.version
    end

    def name
      subject.name
    end

    def to_s
      id.to_s
    end

    def ==(other)
      id == other
    end

    # Detect if running on iOS app webview.
    def ios_app?
      ios? && !ua.include?("Safari")
    end

    # Detect if is iOS webview.
    def ios_webview?
      ios_app?
    end

    # http://msdn.microsoft.com/fr-FR/library/ms537503.aspx#PltToken
    def windows_xp?
      windows? && ua =~ /Windows NT 5\.[12]/
    end

    def windows_vista?
      windows? && ua =~ /Windows NT 6\.0/
    end

    def windows7?
      windows? && ua =~ /Windows NT 6\.1/
    end

    def windows8?
      windows? && ua =~ /Windows NT 6\.[2-3]/
    end

    def windows8_1?
      windows? && ua =~ /Windows NT 6\.3/
    end

    def windows10?
      windows? && ua =~ /Windows NT 10/
    end

    def windows_rt?
      windows8? && ua =~ /ARM/
    end

    # Detect if current platform is Windows in 64-bit architecture.
    def windows_x64?
      windows? && ua =~ /(Win64|x64|Windows NT 5\.2)/
    end

    def windows_wow64?
      windows? && ua =~ /WOW64/i
    end

    def windows_x64_inclusive?
      windows_x64? || windows_wow64?
    end

    def windows_touchscreen_desktop?
      windows? && ua =~ /Touch/
    end
  end
end
