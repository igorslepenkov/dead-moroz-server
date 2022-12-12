class SendWorkingMailToElvesJob
  include Sidekiq::Job

  def perform(*_args)
    elves = User.where(role: Constants::USER_ROLES[:elf])
    elves.each do |elf|
      UserMailer.elves_working_mail(elf).deliver_now
    end
  end
end
