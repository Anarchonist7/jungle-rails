class ModelMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_record_notification.subject
  #
  def new_record_notification(order, email)
    @order = order

    mail to: email, subject: "Order ID: #{@order.id}"
  end
end