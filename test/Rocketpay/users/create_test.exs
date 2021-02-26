defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Vitor",
        password: "123456",
        nickname: "VitorS",
        email: "teste@teste.com",
        age: 28
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Vitor", age: 28, id: ^user_id} = user
    end

    test "when there are invalid params, returns an user" do
      params = %{
        name: "Vitor",
        nickname: "VitorS",
        email: "teste@teste.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
