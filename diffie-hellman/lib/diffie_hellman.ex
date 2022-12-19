defmodule DiffieHellman do

  @doc """
  Given a prime integer `prime_p`, return a random integer between 1 and `prime_p` - 1
  """
  @spec generate_private_key(prime_p :: integer) :: integer
  def generate_private_key(prime_p) do
    Enum.random(1..(prime_p-1))
  end

  @doc """
  Given two prime integers as generators (`prime_p` and `prime_g`), and a private key,
  generate a public key using the mathematical formula:

  (prime_g **  private_key) % prime_p
  """
  @spec generate_public_key(prime_p :: integer, prime_g :: integer, private_key :: integer) :: integer
  def generate_public_key(prime_p, prime_g, private_key) do
    # rem(prime_g ** private_key, prime_p) # <- too slow w/ big vals
    :crypto.mod_pow(prime_g, private_key, prime_p) |> :binary.decode_unsigned()
  end

  @doc """
  Given a prime integer `prime_p`, user B's public key, and user A's private key,
  generate a shared secret using the mathematical formula:

  (public_key_b ** private_key_a) % prime_p
  """
  @spec generate_shared_secret(
          prime_p :: integer,
          public_key_b :: integer,
          private_key_a :: integer
        ) :: integer
  def generate_shared_secret(prime_p, public_key_b, private_key_a) do
    # rem(public_key_b ** private_key_a, prime_p) # <- too slow w/ big vals
    :crypto.mod_pow(public_key_b, private_key_a, prime_p) |> :binary.decode_unsigned()
  end
end
