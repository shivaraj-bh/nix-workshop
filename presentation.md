---
author: Shivaraj
date: MMMM dd, YYYY
paging: Slide %d / %d
---
# Nix (workshop-0)
```bash
jp2a --background=dark nix.png --term-fit --color | 
sed "s/^/$(printf '%*s' $(awk -v v1=$(tput cols) -v v2=2 'BEGIN { print  ( v1 / v2 ) }'))/"
```

---
# What is Nix?
- [x] Linux Distro
- [x] Package Manager
- [x] Expression Language
- [x] And Unlike Real Life, Nix is Reproducible.
- [ ] Difficult to Learn and Use
- [ ] Only for NixOS
```bash
nix run nixpkgs#pfetch
```

<!-- 
Speaker notes: 
- Repeat what the points say, emphasizing on each one of 'em.
- Run the pfetch command with <C-e> on your Mac and do the same on your Ubuntu machine
- Remotely deploy NixOs on that machine and tell audience that we will continue with the workshop while that is happening.
-->

---
## The Need for a New Package Manager
```


```
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
## Advantages of Nix Expression Language
- The text book answer is, "It is a domain-specific, purely functional, lazily evaluated, dynamically typed programming language"
- Taking Configuration Management to the Next Level 
- Flakes is written like a depedency graph, which makes it more intutive.
```nix
# flake1.nix
{
  inputs = {
    input1.url = "<source>";
    input2.url = "<source>";
    # And so on...  
  };
  outputs = {
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
-->

---
# Reproduciblity
- Build happens in a Sandbox environment
- Lock file

<!-- 
Speaker notes: 
- Specify that the Sandbox environment doesn't have access to internet, so it is only dependent on the inputs given to it. 
  If it is Nix flakes, by default it doesn't have access to environment variables either.
- Demonstrate what you mean by access to environment variables using NIXPKGS_ALLOW_BROKEN=1 while trying to build jp2a, with 
  and without flake.
- Mention that most of the answers available online to install packages asks you to use nix-env (global is mostly bad) or to use impure nix-channel
-->

---
# Queries
- Project specific package versions: Node and ormolu version conflicts.
- Let's address this using Nix and direnv...

<!-- 
Speaker notes: 
- Head over to terminal `cd project-0` and show versions of each package mentioned, do the same for project-1
- Speak in breif about the role direnv plays here
-->

---
# Don'ts
- Installing packages in Nix using `nix-env` (which is mostly suggested by Google search results or GPT-3/4)

<!-- 
Speaker notes: 
- Several reasons not to use `nix-env`:
  - It makes the package global (global is bad unless it is something like your browser or code editor)
  - It is not reproducible anymore, as this package is not part of your configuration file.
-->

---
# Larger Perspective
- Flake first
- Nix for all new projects
- NixOS for infra/Local machines

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

