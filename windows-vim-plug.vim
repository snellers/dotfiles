"Some windows specific settings for bootstrapping vim-plug
let need_to_install_plugins = 0

if empty(glob('~/AppData/Local/nvim/autoload/plug.vim'))
    execute ('!C:\Windows\System32\curl -fLo ' .  expand('~/AppData/Local/nvim/autoload/plug.vim') . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    autocmd VimEnter * PlugInstall --sync | source glob('~/AppData/Local/nvim/init.vim')
    let need_to_install_plugins = 1
endif

source $VIMRUNTIME/mswin.vim

