class Backlight
  @@backlight_path = "/sys/class/backlight"

  def initialize(name)
    @path = "#{@@backlight_path}/#{name}"
  end

  def max_brightness
    max_str = File.open("#{@path}/max_brightness", "r") {|f| f.readline}
    return Integer(max_str)
  end

  def set_brightness(n)
      if n > max_brightness
        puts "Brightness too high! (max=#{max_brightness})"
      elsif n <= 0
        puts "Brightness too low!"
      else
        File.open("#{@path}/brightness", "w") {|f| f.write(String(n))}
      end
  end
end

def main
  if ARGV.length() < 1
    puts "Usage: backlight.rb <n>"
    exit
  end

  intel_backlight = Backlight.new("intel_backlight")

  begin
    intel_backlight.set_brightness(Integer(ARGV[0]))
  rescue ArgumentError
    puts "Invalid argument!"
  end
end

main
