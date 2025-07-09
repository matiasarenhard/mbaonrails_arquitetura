class NotifyLowPriceJob < ApplicationJob
  queue_as :default

  def perform(price)
    return if price > 50
    puts "Alerta: o preço está abaixo de #{50} Vamos enviar e-mails e mensagens no zap!"
  end
end
