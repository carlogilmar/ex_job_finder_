defmodule RemoteJobs.PaymentsTest do
  use ExUnit.Case
  doctest Payments

  #alias Payments.Methods.Adapters.Conekta

  # test "world" do
  #   assert :world == Payments.hello()
  # end

  # test "conekta" do
  #   assert :conekta == Conekta.conekta()
  # end

  # test "Success register conekta customer" do
  #   name = "Name"
  #   email = "name@test.mx"
  #   phone = "5584930433"
  #   {:ok, conekta_customer} = Conekta.register_conekta_customer(name, email, phone)
  #   assert conekta_customer
  #   assert conekta_customer.email == email
  #   assert conekta_customer.name == name
  #   assert conekta_customer.phone == phone
  #   assert conekta_customer.id
  # end

  # test "Fail empty name" do
  #   name = ""
  #   email = "name@test.mx"
  #   phone = "5584930433"

  #   assert {:error, "Formato inválido para \"name\"."} ==
  #            Conekta.register_conekta_customer(name, email, phone)
  # end

  # test "Fail empty email" do
  #   name = "Name"
  #   email = ""
  #   phone = "5584930433"

  #   assert {:error, "Formato inválido para \"email\"."} ==
  #            Conekta.register_conekta_customer(name, email, phone)
  # end

  # test "Fail empty phone" do
  #   name = "Name"
  #   email = "name@test.mx"
  #   phone = ""

  #   assert {:error,
  #           "\"phone\" no es un número de télefono válido. Debería de tener al menos 10 digitos (en México lada más los 8 dígitos) y de preferencia el código del país g +52 para México)."} ==
  #            Conekta.register_conekta_customer(name, email, phone)
  # end

  # test "Success register card as payment source" do
  #   credit_card_token = "tok_test_visa_4242"
  #   name = "Name"
  #   email = "name@test.mx"
  #   phone = "5584930433"

  #   {:ok, conekta_customer} = Conekta.register_conekta_customer(name, email, phone)
  #   {:ok, payment_source} = Conekta.register_card(conekta_customer.id, credit_card_token)

  #   assert payment_source
  #   assert payment_source.type == "card"
  #   assert payment_source.object == "payment_source"
  # end

  # test "Fail register payment source with an empty conekta customer id" do
  #   credit_card_token = "tok_test_visa_4242"

  #   assert {:error, "El parametro \"email\" es requerido."} ==
  #            Conekta.register_card("", credit_card_token)
  # end

  # test "Fail register payment source with a nil conekta customer id" do
  #   credit_card_token = "tok_test_visa_4242"
  #   assert {:error, "argument error"} == Conekta.register_card(nil, credit_card_token)
  # end

  # test "Fail register payment source with a empty credit card token" do
  #   name = "Name"
  #   email = "name@test.mx"
  #   phone = "5584930433"
  #   credit_card_token = ""

  #   {:ok, conekta_customer} = Conekta.register_conekta_customer(name, email, phone)

  #   assert {:error, "El token no existe."} ==
  #            Conekta.register_card(conekta_customer.id, credit_card_token)
  # end

  # test "Fail register payment source with a nil credit card token" do
  #   name = "Name"
  #   email = "name@test.mx"
  #   phone = "5584930433"
  #   credit_card_token = nil

  #   {:ok, conekta_customer} = Conekta.register_conekta_customer(name, email, phone)

  #   assert {:error, "El parametro \"token_id\" es requerido."} ==
  #            Conekta.register_card(conekta_customer.id, credit_card_token)
  # end

  # test "Successfull payment with card" do
  #   amount = 5_000
  #   credit_card_token = "tok_test_visa_4242"
  #   name = "Name"
  #   email = "name@test.mx"
  #   phone = "5584930433"

  #   {:ok, conekta_customer} = Conekta.register_conekta_customer(name, email, phone)
  #   {:ok, payment_source} = Conekta.register_card(conekta_customer.id, credit_card_token)

  #   {:ok, order} = Conekta.card_payment(conekta_customer, amount, payment_source.id)
  #   assert order.amount == amount
  #   assert "paid" == List.first(order.charges["data"])["status"]
  #   assert "card_payment" == List.first(order.charges["data"])["payment_method"]["object"]
  # end

  # test "Fail payment with credit card amount equals to 0" do
  #   amount = 0
  #   credit_card_token = "tok_test_visa_4242"
  #   name = "Name"
  #   email = "name@test.mx"
  #   phone = "5584930433"

  #   {:ok, conekta_customer} = Conekta.register_conekta_customer(name, email, phone)
  #   {:ok, payment_source} = Conekta.register_card(conekta_customer.id, credit_card_token)

  #   assert {:error, "\"amount\" no es mayor a 0."} ==
  #            Conekta.card_payment(conekta_customer, amount, payment_source.id)
  # end

  # test "Fail payment with credit card invalid payment source" do
  #   amount = 5_000
  #   name = "Name"
  #   email = "name@test.mx"
  #   phone = "5584930433"
  #   payment_source_id = "invalid value"

  #   {:ok, conekta_customer} = Conekta.register_conekta_customer(name, email, phone)

  #   assert {:error, "La tarjeta no esta asociada al cliente."} ==
  #            Conekta.card_payment(conekta_customer, amount, payment_source_id)
  # end
end
