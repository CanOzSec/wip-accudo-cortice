set number
set nu
set ruler
set expandtab
set autoindent
set softtabstop=4
set shiftwidth=4
set tabstop=4
set wildmode=longest,list

"Enable mouse click for nvim
set mouse=a
"Fix cursor replacement after closing nvim
set guicursor=
"Shift + Tab does inverse tab
inoremap <S-Tab> <C-d>

"See invisible characters
set list listchars=tab:>\ ,trail:+,eol:$
"Don't see invis chars"
set nolist
"wrap to next line when end of line is reached
set whichwrap+=<,>,[,]

call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()


if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}
