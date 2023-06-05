# nix-workshop
Series of workshops on Nix. Starts with showing the magic of Nix and then goes into the details of the language.

Run the workshop slides on your machine:
```bash
nix run github:shivaraj-bh/nix-workshop#<workshop-number>
```
To run the `./examples` within presentation using <kbd>Ctrl-e</kbd>, you will have to clone the repo. Then run: `nix run .#<workshop-number>`

## Development
```bash
git clone https://github.com/shivaraj-bh/nix-workshop
cd nix-workshop
nix develop
slides <workshop-number>/presentation.md
```