RSpec.configure do |config|

  def headless_config
    unless OS.mac?
      headless = Headless.new
      headless.start
    end
  end

  config.before :each do
    headless_config
  end

  config.before :each, :js do
    Capybara.current_driver = :webkit
    headless_config
  end

  config.before :each, :selenium do
    Capybara.current_driver = :selenium
    headless_config
  end

end
