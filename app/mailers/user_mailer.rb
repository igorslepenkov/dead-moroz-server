class UserMailer < ApplicationMailer
  default from: 'mailer.slepenkov@gmail.com'

  def elves_working_mail(elf)
    @elf = elf
    mail(to: elf.email, subject: 'Get back to work you slave!')
  end
end
