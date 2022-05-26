" Shortcuts for wqa typos
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev QA qa
cnoreabbrev qA qa
cnoreabbrev WQ wq
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev Wqa wqa

set cursorline
set noeol
set cursorcolumn
set noswapfile
set tags+=tags;$HOME
set tags=$HOME/.vim/tags,tags;
" OS shared clipboard
set clipboard=unnamed


let g:clipboard = {
  \ 'name': 'pbcopy',
  \ 'copy': {
  \    '+': 'pbcopy',
  \    '*': 'pbcopy',
  \  },
  \ 'paste': {
  \    '+': 'pbpaste',
  \    '*': 'pbpaste',
  \ },
  \ 'cache_enabled': 0,
  \ }
""let g:clipboard = {
""  \   'name': 'xclip-custom',
""  \   'copy': {
""  \      '+': 'env DISPLAY=:0 xclip -quiet -i -selection clipboard',
""  \      '*': 'env DISPLAY=:0 xclip -quiet -i -selection primary',
""  \    },
""  \   'paste': {
""  \      '+': 'env DISPLAY=:0 xclip -o -selection clipboard',
""  \      '*': 'env DISPLAY=:0 xclip -o -selection primary',
""  \   },
""  \ }
""let g:clipboard = {
""    \ 'name': 'xsel',
""    \ 'copy': {
""    \     '+': 'xsel -ib',
""    \     '*': 'xsel -ip'
""    \ },
""    \ 'paste': {
""    \     '+': 'xsel -ob',
""    \     '*': 'xsel -op'
""    \ },
""    \ 'cache_enabled': 1
""    \ }
" OS shared clipboard end config

" Autoclosing custom
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap (;<CR> (<CR>);<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap [;<CR> [<CR>];<ESC>O

autocmd BufWinEnter * if line2byte(line("$") + 1) > 100000 | syntax clear | endif
" set lazyredraw
" set synmaxcol=128
" syntax sync minlines=256
" Required:
filetype plugin indent on


set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set history=700                " Sets how many lines of history VIM has to remember

set nocompatible
set background=dark
syntax enable
syntax on


""""" enable the theme

syntax enable
set showmode

set autoindent
set smartindent
set backspace=eol,start,indent

set expandtab
set tabstop=4
set shiftwidth=4
set ruler

set ignorecase
set smartcase
set hlsearch
set nowrap
set laststatus=2
set cmdheight=2

au FileType python setl sw=4 sts=4 et
au FileType htmldjango setl sw=4 sts=4 et
au FileType css setl sw=2 sts=2 et
au FileType scss setl sw=2 sts=2 et
au FileType js setl sw=2 sts=2 et
au FileType ts setl sw=2 sts=2 et
au FileType tsx setl sw=2 sts=2 et
au FileType go setl sw=4 sts=4 et
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au FileType json setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 expandtab

if exists('loaded_trailing_whitespace_plugin') | finish | endif
let loaded_trailing_whitespace_plugin = 1

if !exists('g:extra_whitespace_ignored_filetypes')
    let g:extra_whitespace_ignored_filetypes = []
endif

function! ShouldMatchWhitespace()
    for ft in g:extra_whitespace_ignored_filetypes
        if ft ==# &filetype | return 0 | endif
    endfor
    return 1
endfunction

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * if ShouldMatchWhitespace() | match ExtraWhitespace /\s\+$/ | endif

" The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * if ShouldMatchWhitespace() | match ExtraWhitespace /\s\+$/ | endif
autocmd InsertEnter * if ShouldMatchWhitespace() | match ExtraWhitespace /\s\+\%#\@<!$/ | endif

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction
highlight Search ctermbg=LightBlue ctermfg=white
vnoremap // y/<C-R>"<CR>


" Convert slashes to backslashes for Windows.
if has('win32')
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap ,cs :let @*=expand("%")<CR>
  nmap ,cl :let @*=expand("%:p")<CR>
endif

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  ""let g:ctrlp_use_caching = 0
endif

" This will not work with the quickfix list apparently
" if executable('rg')
"   " "set grepprg=rg\ --color=never
"   let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
"   let g:ctrlp_use_caching = 0
" endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -complete=file -nargs=+ Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
  command! -bang -complete=file -nargs=+ Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
  " Rg
    nnoremap <silent> <Leader>fa :Find<CR>
  " Rg current worda
  nnoremap <Leader>fw :Rg <C-R><C-W><space>
endif
nnoremap <leader>l :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" let $PYTHONPATH = getcwd()
" " ripgrep
" if executable('rg')
"   let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
"   set grepprg=rg\ --vimgrep
"   command! -bang -complete=file -nargs=+ Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
"   command! -bang -complete=file -nargs=+ Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
"   " Rg
"     nnoremap <silent> <Leader>fa :Find<CR>
"   " Rg current worda
"   nnoremap <Leader>fw :Rg <C-R><C-W><space>
" endif
" nnoremap <leader>l :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" " bind \ (backward slash) to grep shortcut
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!


" To enable the lightline theme
au BufRead,BufNewFile *.md setlocal textwidth=120
au BufRead,BufNewFile *.md setlocal textwidth=120
au BufEnter *.tsx :setlocal filetype=typescript.tsx
