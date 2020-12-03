let mapleader = '\'

" Using just leader as easymotion prefix
map <leader> <Plug>(easymotion-prefix)

" Editing existing mappings
nnoremap / /\v

"File navigation
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<cr>

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

" Maping to get out of insert mode? 'jk'

"Accessing files
"File navigation
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<cr>

"VIMRC
nnoremap <leader>ec :vsplit $MYVIMRC<cr>
nnoremap <leader>sc :source $MYVIMRC<cr>

nnoremap <Leader>]a :ALENext<CR>
nnoremap <Leader>[a :ALEPrevious<CR>
nnoremap <Leader>sr :syntax sync fromstart<CR>

"Additional functionality
"TODO: if LSP does not attach...<leader>rn
nnoremap <leader>s :%s/\v<<c-r><c-w>>//gc<left><left><left>

