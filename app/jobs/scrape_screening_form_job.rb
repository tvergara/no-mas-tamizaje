class ScrapeScreeningFormJob < ApplicationJob
  NO_COVID_BUTTONS = ['label[for="switch_2"]', 'label[for="switch_4"]',
                      'label[for="switch_10"]', 'label[for="switch_28"]',
                      'label[for="switch_30"]', 'label[for="switch_12"]',
                      'label[for="switch_22"]', 'label[for="switch_24"]',
                      'label[for="switch_18"]', 'label[for="switch_20"]',
                      'label[for="switch_26"]', 'label[for="switch_16"]',
                      'label[for="switch_14"]', 'label[for="switch_32"]',
                      'label[for="switch_34"]', 'label[for="switch_36"]',
                      'label[for="switch_38"]']
  def perform(user_id)
    @user = User.find(user_id)
    @intent = FillScreeningFormIntent.create!(user: @user)

    @intent.log('initializing pincers')
    Pincers.for_webdriver :chrome do |pincers|
      @intent.log('pincers initialized')
      @pincers = pincers
      login
      set_user_info
      set_no_covid
      send_form
    end

    @intent.succeed! 
  rescue StandardError => error
    @intent.error_category = 'unknown'
    @intent.error_detail = { message: error.message, backtrace: error.backtrace }.to_json
    
    @intent.fail!
  end

  private

  def login
    @intent.log('logging in')
    @pincers.goto 'https://formulariocovid19.uc.cl/accesouc/index.php'
    @intent.log('log in loaded')
    @pincers.search('#username').set @user.uc_username
    @pincers.search('#password').set @user.uc_password
    @intent.log('credentials entered')
    @pincers.search('.btn-submit').click
    @intent.log('login button clicked')
  end

  def set_user_info
    @intent.log('setting user info')
    @pincers.search('select[name="tipo_persona"]').set @user.uc_member_type
    @pincers.search('select[name="campus"]').set @user.campus
    @pincers.search('#lugar').set @user.campus_place
    @intent.log('user info set')
  end

  def set_no_covid
    @intent.log('setting no covid')
    NO_COVID_BUTTONS.each do |btn|
      @pincers.search(btn).click
    end
    @intent.log('no covid set')
  end

  def send_form
    @intent.log('sending form')
    @pincers.search('a:contains("Enviar")').click
    @intent.log('clicking alert')
    @pincers.element.switch_to.alert.accept
    @intent.log('alert accepted')
    @pincers.search('div.success').text
    @intent.log('successful form submission')
  end
end
