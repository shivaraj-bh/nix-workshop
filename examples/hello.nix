let
  f = i: i + " bar";
in
{
  hello = "world";
  foo = f "foo";
}
