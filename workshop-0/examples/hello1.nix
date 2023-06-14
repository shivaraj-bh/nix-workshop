{
  x =
    let
      g = i: builtins.concatStringsSep "/" i;
      g1 = { i, j }: i * j;
      g2 = inputs@{ i, ... }: i * inputs.j;
    in
    {
      y = g [ "usr" "bin" ];
      z = g1 { i = 10; j = 20; };
      z1 = g2 { i = 10; j = 20; };
    };
}
