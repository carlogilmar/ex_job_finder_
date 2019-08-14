defmodule Payments.Methods.Adapters.Conekta do
  @moduledoc """
  Behaviour for the payments module
  """

  alias Conekta.Customers
  alias Conekta.Orders

  @job_cost Application.get_env(:remote_jobs, :job_price)

  def conekta do
    :conekta
  end

  def register_conekta_customer(name, email, phone) do
    new_customer = %Conekta.Customer{
      name: name,
      email: email,
      phone: phone,
      corporate: true
    }

    with {:ok, customer} <- create_customer(new_customer) do
      {:ok, customer}
    else
      {:error, e = %ConektaError{}} ->
        {:error, e.message}
    end
  end

  def register_card(conekta_customer_id, token) do
    payment_source = %Conekta.PaymentSource{token_id: token, type: "card"}

    with {:ok, payment_source} <- create_payment_source(conekta_customer_id, payment_source) do
      {:ok, payment_source}
    else
      {:error, e = %ConektaError{}} ->
        {:error, e.message}

      {:error, e = %ArgumentError{}} ->
        {:error, e.message}
    end
  end

  def card_payment(conekta_customer, amount, conekta_payment_id) do
    with {:ok, new_order} <-
           create_credit_card_order(conekta_customer, amount, conekta_payment_id),
         {:ok, order} <- create_order(new_order) do
      {:ok, order}
    else
      {:error, e = %ConektaError{}} ->
        {:error, e.message}

      {:error, message} ->
        {:error, message}
    end
  end

  def create_credit_card_order(customer, amount, conekta_payment_id) do
    charge = %Conekta.Charge{
      amount: amount,
      payment_method: %{type: "card", payment_source_id: conekta_payment_id}
    }

    new_order = %Conekta.Order{
      currency: "MXN",
      customer_info: %{
        customer_id: customer.id
      },
      line_items: [
        %{
          name: "Pago por Servicio",
          unit_price: amount,
          quantity: 1
        }
      ],
      charges: [charge]
    }

    {:ok, new_order}
  end
  
  def create_card_order_with_token(name, email, card_token) do

    new_order = %Conekta.Order{
      currency: "MXN",
      customer_info: %{
        name: name,
        email: email,
        phone: "5500000000",
      },
      line_items: [%{
        name: "Publish a job",
        unit_price: @job_cost,
        quantity: 1
      }],
      charges: [%{
        amount: @job_cost,
        payment_method: %{
          type: "card",
          token_id: card_token,
        },
      }]
    }

    with {:ok, created_order } <- create_order(new_order) do
      {:ok, created_order}
    else {:error, error} ->
      {:error, error}
    end

  end

  defp create_customer(new_customer) do
    try do
      {:ok, _customer} = Conekta.Customers.create(new_customer)
    rescue
      e ->
        {:error, e}
    end
  end

  defp create_payment_source(conekta_customer_id, payment_source) do
    try do
      Conekta.Customers.create_payment_source(conekta_customer_id, payment_source)
    rescue
      e ->
        {:error, e}
    end
  end

  defp create_order(order) do
    try do
      {:ok, _order} = Conekta.Orders.create(order)
    rescue
      e ->
        {:error, e}
    end
  end
end
