{ pkgs, lib, config,  hostName, ... }:

{
	programs.neovim = {
		enable = true;
		#withNodeJs = true;

		#extraPackages = 
		#[
		#	pkgs.tree-sitter
		#];
		#configure = {
		plugins = with pkgs.vimPlugins; [
			telescope-nvim
			plenary-nvim
			telescope-fzf-native-nvim
			harpoon
			oil-nvim
			todo-comments-nvim
			nvim-treesitter.withAllGrammars
			nvim-web-devicons
			vim-fugitive
			#mason-nvim
			#neovim/mason-lspconfig
		];

		#	treesitter = {
		#		enable = true;
		#		parsers = [
		#			"lua"
		#			"javascript"
		#			"svelte"
		#			"typescript"
		#		];
		#	};
		#};
	};
	xdg.configFile.nvim.source = "./neovim"
}
