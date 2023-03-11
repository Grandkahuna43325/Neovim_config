# Neovim_config

Przerobiony NvChad

jeśli ktoś szuka informacji to odsyłam do https://github.com/NvChad/NvChad


Jeśli ktoś po prostu skopiuje te pliki to one nie zadziałają!!!

Postępujcie zgodnie z instrukcjami tutaj:
https://nvchad.github.io/#/docs/quickstart/install

Jak już wszystko się pobierze to wpiszcie w terminalu:

rm -rf ~/.config/nvim/*
git clone https://github.com/Grandkahuna43325/Neovim_config ~/.config/nvim --depth 1 && nvim +PackerSync
cd .local/share/nvim/site/pack/packer
cp -r opt/telescope.nvim /start/

