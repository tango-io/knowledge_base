RSpec.configure do |config|
  @headless = Headless.new

  config.before :each do
    unless OS.mac?
      @headless.start
    end
  end

  config.after :each do
    unless OS.mac?
      @headless.stop
    end
  end

  config.before :each, :js do
    Capybara.current_driver = :webkit
    unless OS.mac?
      @headless.start
    end
  end

  config.after :each, :js do
    unless OS.mac?
      @headless.stop
    end
  end

  config.before :each, :selenium do
    Capybara.current_driver = :selenium
    unless OS.mac?
      @headless.start
    end
  end

  config.after :each, :selenium do
    unless OS.mac?
      @headless.stop
    end
  end
end
