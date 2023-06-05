---
author: Shivaraj
date: MMMM dd, YYYY
paging: Slide %d / %d
---
# Nix (workshop-0)
```



                                                   ',,'       .cllll,     .cll.
                                                  ,cccc;       'kkkkk:   .xkkkk.
                                                   ,cccc:.      .xkkkkl ;kkkkk;
                                                    'ccccc.       okkkkxkkkkk.
                                              .'''''':ccccc,'''''''lkkkkkkkx.
                                             ,ccccccccccccccccccccc;:kkkkkx       .c.
                                            ,:::::::::::::::::::::::;,kkkkk:     'ccc'
                                                    .lllll;           .xkkkkl   ,cccc:
                                                   .kkkkkc              dkkkko :cccc:
                                                  ;kkkkk,                lkkx,:cccc;
                                       ;ooooooooodkkkkx.                  :d'cccccc:;;;;;;.
                                      ,kkkkkkkkkkkkkkd.                    'ccccccccccccccc
                                       ,ccccccdkkkkko,c.                  ,cccc:,,,,,,,,,,
                                             'kkkkkc,ccc'                ;cccc:
                                            ;kkkkk, :cccc;             .:cccc,
                                           ;kkkkk.   :cccc:           .;;;;;,
                                            ckkd.     ;ccccc,xkkkkkkkkkkkkkkkkkkkkkkk.
                                             ;o       .cccccc'dkkkkkkkkkkkkkkkkkkkkx.
                                                     'cccccccc,'''''''ckkkkkl''''''
                                                    ;ccccc:cccc,       ;kkkkk,
                                                   :cccc:  :cccc;       'kkkkk:
                                                  'cccc,    ;cccc:.      .xkkkk.
                                                   .''.      .'''''        ;;;.
```

<!-- 
Speaker notes: 
- Introduce yourself briefly and speak about your motivation to use Nix
- Credit everyone who has helped in preparing the slides
-->

---
## The Need for a New Package Manager

### Lost in the Maze of Installation Options? 
- Let's Navigate: Apt, Snap, Pacman, Brew (and More)!
### Play It Safe:
- Run Packages in a Sandbox Environment and 'Try Before You Buy' with Confidence!
### Stay Ahead of the Game:
- Get the Latest Packages with the Most Up-to-Date Software Selection (Source: https://repology.org)!

<!-- 
Speaker notes: 
- Elaborate on point 1 by speaking about how managing different package manager can get messy when you are switching platforms.
- Speak about how you ran the same nix command to run pfetch package on Mac and ubuntu
- Make a connection to haskell purity while talking about purity in Nix
- The user wouldn't want to use `nix run` always, and would prefer to have a package installed... this is when you introduce home-manager
- But then the syntax might be a little confusing for the audience, so you move to next slide with a quick introduction to the syntax
  and then you switch back to home-manager configs... Aha now it all makes sense!
-->

---
## Advantages of Nix Expression Language
- The text book answer is, "It is a domain-specific, purely functional, lazily evaluated, dynamically typed programming language"
- Taking Configuration Management to the Next Level 
- You can think of it as a JSON but with functions
```bash
cat workshop-0/examples/hello.nix
```

---
## Let's evaluate
```bash
nix eval -f workshop-0/examples/hello.nix hello
nix eval -f workshop-0/examples/hello.nix foo
```

---
## Level Up!

```bash
cat examples/hello1.nix
nix eval -f workshop-0/examples/hello1.nix x
nix eval -f workshop-0/examples/hello1.nix x.y
```
---
## Basic Flake
```nix
# flake1.nix
{
  inputs = {
    input1.url = "<source>";
    input2.url = "<source>";
    # And so on...  
  };
  outputs = {...}:{
    # Perform some operations using inputs
  }; 
}

```
```nix
# Use flake1.nix as input
{
  inputs = {
    input1.url = "<path-to-flake1.nix>";
    input2.url = "<source>";
  };
  outputs = {};
}
```
<!-- 
Speaker notes: 
- Before starting off, specify that throughout the presentation it will be Nix flakes anytime I mention Nix.
- Explain with analogy, take configuration files that people already know of and relate it to Nix.
- Explain how Nix enables the management of multiple configurations such as Dockerfile, Makefile, Jenkinsfile
  , package.json, requirements.txt ... all within Nix.
- Each flake takes a set of inputs (following input schema), processes them based on the program and generates 
  output (following output schema). Input can be another flake, source-code, non-flake, pretty much anything; given
  you know what to do with it.
- Link it with package.json
- TODO: add basic examples
-->

---
# Queries
- Project specific package versions: Node and ormolu version conflicts.
- Let's address this using Nix and direnv...

<!-- 
Speaker notes: 
- Head over to terminal `cd project0` and show versions of each package mentioned, do the same for project1
- Speak in breif about the role direnv plays here
-->

---
# Reproduciblity
- Build happens in a Sandbox environment
- Lock file
- Derivation hash

<!-- 
Speaker notes: 
- Specify that the Sandbox environment doesn't have access to internet, so it is only dependent on the inputs given to it. 
  If it is Nix flakes, by default it doesn't have access to environment variables either.
- Demonstrate what you mean by access to environment variables using NIXPKGS_ALLOW_BROKEN=1 while trying to build jp2a, with 
  and without flake.
- Mention that most of the answers available online to install packages asks you to use nix-env (global is mostly bad) or to use impure nix-channel
-->

---
## What Makes NixOS Stand Out?
- Unleash Your Potential: Don't Settle for Just Configuring Software Applications!
### Boom!
```
~~~graph-easy
[ Infrastructure as Code ]
~~~
```
- Hardware configuration
- Kernel Configuration
- Easy rollback
<!-- 
Speaker notes: 
- Hardware configuration (eg. disk partitioning)
- Kernel configuration (eg. specify a specific kernel version or build your own custom kernel if needed, configure
  your boot loader and configure drivers for various hardware devices like your graphics card)
- Easy rollback
-->

---
# Larger Perspective for Juspay
- Flake first
- Nix for all new projects
- Move existing projects to Nix (In-progress for Euler)

---
# Read More
- Nix Demystified (https://www.tweag.io/blog/2022-07-14-taming-unix-with-nix/)
- Stop using nix-env (https://stop-using-nix-env.privatevoid.net)
- See section: "WHAT PROBLEMS DO FLAKES SOLVE?" (https://www.tweag.io/blog/2020-05-25-flakes)

---
# Templates
- Dotfiles with flake (https://github.com/srid/nixos-flake)
- Hello-world home-manager flake for Dev's (https://github.com/juspay/nix-dev-home)
- Haskell project template using haskell-flake (https://github.com/srid/haskell-template)

---
# Projects to Watch!
- haskell-flake (https://github.com/srid/haskell-flake)
- Nammayatri backend (https://github.com/juspay/nammayatri/nammayatri)
  - Appreciation from external users: https://github.com/orgs/nammayatri/discussions/264#discussioncomment-5478665
- Jenkins CI NixOS configuration (https://github.com/juspay/jenkins-nix-ci)
- Log processor (Internal repository)

---
# Upcoming
- Manage your VScode extensions, Nvim plugins in home-manager
- Manage secrets with sops-nix
- If you would like to see something specific, feel free to ping in #nix or DM
