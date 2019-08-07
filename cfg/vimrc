"" --- language server ---
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly-2019-02-08', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ }

let g:lsp_signs_enabled = 1           " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

" completion
let g:deoplete#enable_at_startup = 1

" Default indentation settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" line numbering
set number

" turn on syntax highlighting
syntax on
syntax enable

" turn on spell checking
:setlocal spell
:setlocal spell spelllang=en_us

" remap jk to esc
:inoremap jk <Esc>

" remap arrow keys to nothing in normal mode
:noremap <Up> <nop>
:noremap <Down> <nop>
:noremap <Left> <nop>
:noremap <Right> <nop>

" linting
let g:ale_rust_cargo_use_check = 1
let g:ale_rust_cargo_check_all_targets = 1

" remap leader
let mapleader = ","

" use fzf as ctl-p
nnoremap <silent> <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" use rg for grep
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" vim theme (used with altercation/vim-colors-solarized)
set background=dark
colorscheme solarized
let g:solarized_termcolors=256

" subtle highlight for matching brackets
highlight MatchParen cterm=bold ctermbg=none ctermfg=blue

" Airlines theme (vim-airline)
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" enable backspace/delete (mac)
set backspace=indent,eol,start

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" wrap errors at bottom of vim screen
autocmd FileType qf setlocal wrap

" ------ Python Settings ------

" python syntax highlighting
let python_highlight_all=1

autocmd FileType python set tabstop=4
autocmd FileType python set softtabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set textwidth=0
autocmd FileType python set expandtab
autocmd FileType python set autoindent
autocmd FileType python set fileformat=unix

au FileType python let b:dispatch = 'fli service test .'
au FileType python nmap <leader>t :Dispatch!<CR>

" auto format on save
"let g:black_linelength = 100
"autocmd BufWritePre *.py execute ':Black'

" ------ PHP Settings ------

autocmd FileType php set tabstop=4
autocmd FileType php set softtabstop=4
autocmd FileType php set shiftwidth=4
autocmd FileType php set expandtab
autocmd FileType php set autoindent
let g:ale_php_phpstan_use_global = 1

" ------ JS Settings ------
autocmd FileType javascript set tabstop=2
autocmd FileType javascript set softtabstop=2
autocmd FileType javascript set shiftwidth=2
autocmd FileType javascript set expandtab
autocmd FileType javascript set autoindent

" ------ Typescript -------
autocmd FileType typescript nmap <leader>g :call LanguageClient_textDocument_definition()<CR>
autocmd FileType typescript nmap <leader>d :call LanguageClient_textDocument_hover()<CR>
autocmd FileType typescript set tabstop=2
autocmd FileType typescript set softtabstop=2
autocmd FileType typescript set shiftwidth=2
autocmd FileType typescript set expandtab
autocmd FileType typescript set autoindent

" ------ Jenkinsfile Settings ------
" treat Jenkinsfile.* files as Jenkinsfile files
autocmd BufNewFile,BufRead Jenkinsfile.* set filetype=Jenkinsfile
autocmd FileType Jenkinsfile set tabstop=2
autocmd FileType Jenkinsfile set softtabstop=2
autocmd FileType Jenkinsfile set shiftwidth=2
autocmd FileType Jenkinsfile set expandtab
autocmd FileType Jenkinsfile set autoindent

" ------ API blueprint (.apib) settings
autocmd FileType apiblueprint set expandtab
autocmd FileType apiblueprint set tabstop=4
autocmd FileType apiblueprint set softtabstop=4
autocmd FileType apiblueprint set shiftwidth=4

" ------ toml (.toml) settings
autocmd FileType toml set expandtab
autocmd FileType toml set autoindent
autocmd FileType toml set tabstop=2
autocmd FileType toml set softtabstop=2
autocmd FileType toml set shiftwidth=2

" ------ c++ (.cpp) settings
autocmd FileType cpp set expandtab
autocmd FileType cpp set autoindent
autocmd FileType cpp set tabstop=2
autocmd FileType cpp set softtabstop=2
autocmd FileType cpp set shiftwidth=2

autocmd BufNewFile,BufRead *xmobarrc set filetype=haskell

" ------ Rust-lang Settings ------
autocmd FileType rust let b:dispatch = 'cargo test'
autocmd FileType rust nmap <leader>b :Dispatch cargo build<CR>
autocmd FileType rust nmap <leader>r :!cargo run<CR>
autocmd FileType rust nmap <leader>t :Dispatch<CR>
autocmd FileType rust nmap <leader>c :Dispatch cargo check<CR>

autocmd FileType rust nmap <leader>g :call LanguageClient_textDocument_definition()<CR>
autocmd FileType rust nmap <leader>d :call LanguageClient_textDocument_hover()<CR>

"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
let g:rustfmt_autosave = 1
let g:racer_cmd = "/Users/andrewwright/.cargo/bin/racer"

" ------ go-lang Settings ------
"let g:go_version_warning = 0
" treat .go.tmpl files as go files
autocmd BufNewFile,BufRead *.go.tmpl set filetype=go

autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>g <Plug>(go-def)
autocmd FileType go nmap <leader>l <Plug>(go-metalinter)
autocmd FileType go nmap <leader>d <Plug>(go-doc)

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_fmt_command = "goimports"

au BufNewFile,BufRead *.go,*.go.gotmpl setlocal noet ts=4 sw=4 sts=4

" ------ crontab Settings ------
autocmd filetype crontab setlocal nobackup nowritebackup

" ------ ledger settings -------
autocmd BufNewFile,BufRead *.journal set filetype=ledger
