---
author: Shivaraj
date: MMMM dd, YYYY
paging: Slide %d / %d
---

# Nix expression language (workshop-1)
## Let's learn Nix by examples!
### Write your first derivation
### Setup a development environment for the workshop material

---

## Quick Recap
### What is an attribute set?
```nix
{ foo = 1; bar = 2; }
```
### How do you define a function?
```nix
# Single parameter
foo: foo*2
# Multiple parameters
foo: bar: foo + bar
# Above is equivalent to
foo: (bar: foo + bar)
# Attrset as a parameter
{ foo, bar }: foo + bar
```
---
### Imports
examples/a.nix
```nix
{ x?1, y?2 }: x + y
```
examples/b.nix
```nix
{ i = import ./a.nix {}; j = import ./a.nix { x = 3; y = 4}; }
```
---
### Evaluate
```bash
nix eval -f workshop-1/examples/b.nix i
nix eval -f workshop-1/examples/b.nix j
```
---

## Builtin functions in Nix
### builtins attrset is a collection of all the builtin functions
### Example functions from builtins
```nix
map :: (a -> b) -> [a] -> [b]
```
For example:
```nix
map (x: "hello" + x) [ "world" "nix" ]
```
evaluates to
```nix
[ "helloworld" "hellonix" ]
```
---
### One more example
```nix
mapAttrs :: (a -> b -> c) -> AttrSet -> AttrSet
```
For example:
```nix
mapAttrs (name: value: name + value) { foo = "bar"; hello = "world"; }
```
evaluates to
```nix
{ foo = "foobar"; hello = "helloworld"; }
```
---
### And a couple more
```nix
concatLists :: [List] -> []
readFile :: Path -> String
```
### Search engine for all the builtin functions and more
https://noogle.dev/
---
### Write your first derivation
