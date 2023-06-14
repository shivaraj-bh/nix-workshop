# nix-workshop
This is a collection of workshops that cover Nix, starting with an introduction to its magic and then diving deeper into Nix with a flakes-first approach.

Run the workshop slides on your machine:
```bash
nix run github:shivaraj-bh/nix-workshop#workshop-<number>
```

## Development
```bash
git clone https://github.com/shivaraj-bh/nix-workshop
cd nix-workshop
nix develop
slides workshop-<number>/presentation.md
```

## Tips
- To run the code blocks (that references other files from the project) within presentation using <kbd>Ctrl-e</kbd>, you will have to clone the repo. Then run: `nix run .#workshop-<number>`