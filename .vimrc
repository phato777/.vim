set nocompatible              						"We want the latest Vim settings/options.

so ~/.vim/plugins.vim

syntax enable
set backspace=indent,eol,start                                          "Make backspace behave like every other editor.
let mapleader = ',' 						    	"The default is \, but a comma is much better.
set number								"Let's activate line numbers.
set noerrorbells visualbell t_vb=               			"No damn bells!
set autowriteall                                                        "Automatically write the file when switching buffers.
set complete=.,w,b,u 							"Set our desired autocompletion matching.
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4




"-------------Visuals--------------"
colorscheme elflord
set background=dark
set t_CO=256								"Use 256 colors. This is useful for Terminal Vim.
set guifont=Fira\ Code:h17						"Set the default font family and size.
"set macligatures							"We want pretty symbols, when available.
set guioptions-=e							"We don't want Gui tabs.
set linespace=16   						        "Macvim-specific line-height.
"set lines=999

set guioptions-=l                                                       "Disable Gui scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R
set wrap!

"We'll fake a custom left padding for each window.
hi LineNr guibg=bg
"set foldcolumn=2
hi foldcolumn guibg=bg

"Get rid of ugly split borders.
hi vertsplit guifg=bg guibg=bg
hi vertsplit ctermfg=black ctermbg=grey




"-------------Search--------------"
set hlsearch								"Highlight all matched terms.
set incsearch								"Incrementally highlight, as we type.




"-------------Split Management--------------"
set splitbelow 								"Make splits default to below...
set splitright								"And to the right. This feels more natural.

"We'll set simpler mappings to switch between splits.
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>




"-------------Mappings--------------"
"Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader>es :e ~/.vim/snippets/

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

"Quickly browse to any tag/symbol in the project.
"Tip: run ctags -R to regenerated the index.
nmap <Leader>f :tag<space>

"Sort PHP use statements
"http://stackoverflow.com/questions/11531073/how-do-you-sort-a-range-of-lines-by-length
vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>

"ctags
if has('win32') || has('win32unix')
    nmap <Leader>ct :!ctags.exe -R --exclude=.git --exclude=bootstrap --exclude=config --exclude=database --exclude=node_modules --exclude=packages --exclude=public --exclude=resources --exclude=routes --exclude=secure --exclude=storage --exclude=tests --exclude=wf<cr>
else
    nmap <Leader>ct :!ctags -R --exclude=.git --exclude=bootstrap --exclude=config --exclude=database --exclude=node_modules --exclude=packages --exclude=public --exclude=resources --exclude=routes --exclude=secure --exclude=storage --exclude=tests --exclude=wf<cr>
endif

"close buffer and replace with next
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>


"-------------Plugins--------------"

"/
"/ CtrlP
"/
"let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_match_window  = 'top,order:ttb,min:1,max:30,results:30'
let g:ctrlp_extensions = ['buffertag']
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files=0
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|node_modules$\|bootstrap$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

nmap <C-p> :CtrlP<cr>
"nmap <C-r> :CtrlPBufTag<cr>
nmap <C-e> :CtrlPMRUFiles<cr>
"nmap <D-t> <Plug>PeepOpen

"/
"/ NERDTree
"/
let NERDTreeHijackNetrw = 0

nmap <Leader>1 :NERDTreeToggle<cr>

"/
"/ Greplace.vim
"/
set grepprg=ag								"We want to use Ag for the search.

let g:grep_cmd_opts = '--line-numbers --noheading'

"/
"/ vim-php-cs-fixer.vim
"/
let g:php_cs_fixer_level = "psr2"  

nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<CR>

"/
"/ pdv
"/
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"

nnoremap <leader>d :call pdv#DocumentWithSnip()<CR>

"/
"/ Ultisnips
"/
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"/
"/ vim-blade
"/
" Define some single Blade directives. This variable is used for highlighting only.
let g:blade_custom_directives = ['vcomponent']


"-------------Laravel-Specific--------------"
nmap <Leader>lr :e app/Http/routes.php<cr>
nmap <Leader>lm :!php artisan make:
nmap <Leader><Leader>c :e app/Http/Controllers/<cr>
nmap <Leader><Leader>m :CtrlP<cr>app/
nmap <Leader><Leader>v :e resources/views/<cr>

"/
"/ vim-workspace
"/
let g:workspace_autosave_untrailspaces = 0



"-------------Auto-Commands--------------"
"Automatically source the Vimrc file on save.

augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END




"-------------Functions--------------"
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>




"-------------Tips and Reminders--------------"
" - Press 'zz' to instantly center the line where the cursor is located.
" - Press ctrl+^ to goto previous buffer
" - Press ctrl+] to goto the symbol
" - :!ctags.exe -R --exclude=node_modules
" cool
