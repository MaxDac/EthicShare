defmodule EthicShareWeb.JwtToken do
  @moduledoc false

  use Joken.Config

  @signer Joken.Signer.create("HS256", "site-secret")

  @spec get_jwt_token(String.t()) :: {:error, atom | keyword} | {:ok, binary}
  def get_jwt_token(id) do
    extra_claims = %{
      "user_id" => id
    }

    case generate_and_sign(extra_claims, @signer) do
      {:ok, token, _claims} -> {:ok, token }
      r -> r
    end
  end

  @spec validate_jwt_token(binary) :: {:error, atom | keyword} | {:ok, any}
  def validate_jwt_token(token) do
    case verify_and_validate(token, @signer) do
      {:ok, %{"user_id" => user_id}} ->
        {:ok, user_id}
      r ->
        r
    end
  end

end
