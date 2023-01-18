# Script - Sieve of Eratosthenes Walkthrough

## Problem

- Exercism
  - Go do it.
- Sieve of Eratosthenes
  - Wikipedia
  - Alorithm:
    - Start with list of 2 to n
    - Take number the first number, p (2 to start)
    - Add it to list of primes
    - Remove all multiples of p from the first list
      (4, 6, 8, ...)
    - take next remaining number, p2 (3)
    - Add it to list of primes
    - remove all remaining multples of p2  
      (9, 15, 21, ...)
    - take next remaining number, p3 (5)
    ... keep repeating until first list is empty

Sound like a perfect problem to solve with a little 
tail recursion.

First, we know we're going to need to remove all
of a number from a list, so let's write a little 
helper function to do that.

We'll pop in to the REPL to flesh that out.

Elixir has a built in operator macro (--) to remove the 
elements of one list from another.

So if we have a list of the numbers from 2 to 10

```elixir
iex> l1 = Enum.to_list(2..10)
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

and another list of the multiples of 2 up to 10:

```elixir
iex> l2 = Enum.to_list(4..10//2)
[2, 4, 6, 8, 10]
```

We can just say: 

```elixir
iex> l1 -- l2
[3, 5, 7, 9]
```

So let write a function that takes a base number and
list and removes the multiples the base from the 
list:

```elixir
def remove_multiples(base, list), do: list - Enum.to_list((base * 2)..List.last(list))
```


Easy peasy. Let's test it in the REPL:

```elixir
iex> recompile
:ok
iex> Sieve.remove_multiples(2, [3, 4, 5, 6, 7, 8, 9, 10])
[3, 5, 7, 9]
```

Perfect.

This function isn't part of our API, so we'll make it 
private. 

```elixir
defp remove_multiples(base, list), do: list - Enum.to_list((base * 2)..List.last(list))
```
Now let's look at that illustration of our algorithm again:

Okay so our recursive funciton will have two lists,
starting with a list of the range 2 to the given limit,
and an empty list that we'll fill up with our primes.

Let's call it sift, keeping with our Sieve metaphor.

```elixir
def primes_to(limit), do: sift(Enum.to_list(2..limit), [])
```

When we call it, we'll want pluck the first number from
the list and add it to our primes. Then remove its 
multiples, and pass both back to the sift function again.

```elixir
def sift([p | tail], primes), do sift(remove_multiples(p, tail), [p | primes])
```

When we get to the last remaining element in the list (i.e.
the tail is empty), we can stop recursing and just return 
the list of primes. 

```elixir
def sift([p | []], primes), do: primes
```

Let's test it in the REPL.

```elixir
iex> recompile
:ok
iex> Sieve.primes_to 10
[7, 5, 3, 2]
```

Uh oh. Looks like we'll need to reverse the primes list
because we built it up backwards. We could add each element 
to the end of the prime list, building up in the correct order,
but it's cheaper to do it this way.

```elixir
def sift([p | []], primes), do: Enum.reverse primes
```

Let's test it in the REPL

```elixir
iex> recompile
:ok
iex> Sieve.primes_to 10
[2, 3, 5, 7]
```

Looks good. Let's run our tests.

Oops. Our spec says "any non-negative integer, so we'll
have to accomodate 0 and 1. No worries lets overload our 
primes_to/1 function with a guard.

And test again.
Voila!

We've solved the exercise with 5 simple one-line functions.

This certainly isn't the only way to solve the problem,
but it's short, simple, and I think pretty clear.

Until next time.
Happy coding.