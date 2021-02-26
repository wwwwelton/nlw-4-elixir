defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "any_name",
      password: "any_password",
      nickname: "any_nickname",
      email: "any_mail@mail.com",
      age: 30
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "any_name",
        nickname: "any_nickname"
      }
    }

    assert expected_response == response
  end
end
