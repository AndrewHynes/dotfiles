
execute pathogen#infect()

set autoindent
set nu
syntax on
filetype on

set relativenumber
set number

filetype indent on
filetype plugin indent on
filetype plugin on
set omnifunc=syntaxcomplete#Complete


let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
