# Transcript - Sieve of Eratosthenes Walkthrough

## Problem

- Exercism
  - For those who aren't familiar with Exercism, it's an awesome site 
    that let's developers practice their skill by working through
    coding exercises. They have "tracks" for dozens of different languages.
    When you complete an exercise, the tool will give you some basic feedback
    on your code. You can also publish it for others to review, and, optionally, 
    comment on. For even more feedback you can request to have a mentor work with
    you on your solution, or provide mentorship yourself.

- Sieve of Eratosthenes
  - One of the exercises in the Elixir track, is to implement a prime number
    generator using the "Sieve of Eratosthenes" algorithm. Looking through the users'
    submission, I saw a lot of very inventive solutions. Most were 20 or 30 lines of 
    code, some more than 60. My solution was 5 one-line funcions. 

    Shorter isn't always better. Sometimes a few extra lines of code are good if 
    they provide clarity or flexibility. But when we're talking about a 5x or 10x
    difference, with complicated logic, ... well maybe it's time for some condensing.

    Let's walk through a short, simple solution to this exercise.

  - The algorithm is published on Wikipedia, with nice animated gif that illustrates
    our path.

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

Sounds like a perfect problem to solve with a little tail recursion.

First, we know we're going to need to remove all of a number from a list, so let's write a little helper function to do that.

We'll pop in to the REPL to flesh that out.<sup>1<sup>

Elixir has a built in operator macro (--) to remove the 
elements of one list from another.

So if we have a list of the numbers from 2 to 10

```elixir
iex> list = Enum.to_list(2..10)
[2, 3, 4, 5, 6, 7, 8, 9, 10]
```

and another list of the multiples of 2 up to 10:

```elixir
iex> mults = Enum.to_list(2..10//2)
[2, 4, 6, 8, 10]
```

We can just say: 

```elixir
iex> list -- mults
[3, 5, 7, 9]
```

So let write a function that takes a base number and
list and removes the multiples the base from the 
list:

```elixir
def remove_multiples(base, list), do: list - Enum.to_list(base..List.last(list))
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

---

Let's review the elements that made our solution short and simple:

### Ranges

A basic type representing a series of integers. Ranges can be written using the
literal start..end: 

```elixir
2..10
# 2, 3, 4, 5, 6, 7, 8, 9 10
```

By default the series increments by 1, but an optional "step" value can be 
given to change the incremental value.

```elixir
iex> 2..10//2
# 2, 4, 6, 8, 10
```

To cast a range into a list, we used the `Enum.to_list/1` function:

```elixir
iex> Enum.to_list(2..10//2)
[2, 4, 6, 8, 10]
```

### The `--` Operator

Next we used the `--` operator macro to remove the elements of one list
from another:

```elixir
iex> [2, 3, 4, 5, 6, 7, 8, 9, 10] -- [2, 4, 6, 8, 10]
[3, 5, 7, 9]
```

### Tail Call Recursion 

Our next big tool was tail recursion. Tail recursion is simply when 
the last expression in a function is to call itself. Sometimes using 
recursion we can wind up a chain of nested call on the stack, putting
some serious limitations on scale and performance. But when the recursive
call is the very last thing to occur in the function, there's no need to 
build up a stack. The compiler recognizes this and simply moves the pointer 
back to the beginning of the function. Don't worry if this sounds complicated; 
it's simple to implement. All it means is that when you do recursion, if a function
makes a call back to itself as the very last step, you're good to go.

Resources:

- https://elixir-lang.org/getting-started/recursion.html
- https://exercism.org/tracks/elixir/concepts/tail-call-recursion
