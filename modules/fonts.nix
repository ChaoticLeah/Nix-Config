{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
		fira-code
		fira-code-symbols
    nerd-fonts.fira-code
    maple-mono.truetype
    maple-mono.NF-unhinted
  ];
}
