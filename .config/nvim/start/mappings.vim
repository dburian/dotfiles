let mapleader = '\'

"Pane navigation
nnoremap <c-l> <c-w>l
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h

inoremap <c-l> <Esc><c-w>l
inoremap <c-k> <Esc><c-w>k
inoremap <c-j> <Esc><c-w>j
inoremap <c-h> <Esc><c-w>h


"Removing old habits
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> ddkP
nnoremap <Down> ddp

inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>

inoremap <delete> <nop>

" Extra functionality

"Typing
nnoremap <leader>U viwUe
inoremap <leader>U <esc>viwUea

"Accessing files
"VIMRC
nnoremap <leader>ec :vsplit $MYVIMRC<cr>
nnoremap <leader>sc :source $MYVIMRC<cr>

nnoremap <Leader>sr :syntax sync fromstart<CR>

"Additional functionality
"TODO: if LSP does not attach...<leader>rn
nnoremap <leader>s :%s/\v<<c-r><c-w>>//gc<left><left><left>

