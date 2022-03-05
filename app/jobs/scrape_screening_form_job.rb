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

    Pincers.for_webdriver :chrome do |pincers|
      @pincers = pincers
      login
      set_user_info
      set_no_covid
      @pincers.search('a:contains("Enviar")').click
      @pincers.element.switch_to.alert.accept
    end
  end

  private

  def login
    @pincers.goto 'https://formulariocovid19.uc.cl/accesouc/index.php'
    @pincers.search('#username').set @user.uc_username
    @pincers.search('#password').set @user.uc_password
    @pincers.search('.btn-submit').click
  end

  def set_user_info
    @pincers.search('select[name="tipo_persona"]').set @user.uc_member_type
    @pincers.search('select[name="campus"]').set @user.campus
    @pincers.search('#lugar').set @user.campus_place
  end

  def set_no_covid
    NO_COVID_BUTTONS.each do |btn|
      @pincers.search(btn).click
    end
  end
end
