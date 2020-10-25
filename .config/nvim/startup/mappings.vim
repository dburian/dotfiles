let mapleader = '\'

"File navigation
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :CtrlP<CR>
inoremap <F2> <Esc>:NERDTreeToggle<CR>
inoremap <F3> <Esc>:CtrlP<CR>

"Pane navigation
nnoremap <C-L> <C-W>l
nnoremap <C-K> <C-W>k
nnoremap <C-J> <C-W>j
nnoremap <C-H> <C-W>h

inoremap <C-L> <Esc><C-W>l
inoremap <C-K> <Esc><C-W>k
inoremap <C-J> <Esc><C-W>j
inoremap <C-H> <Esc><C-W>h

"Removing old habits
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> ddkP
nnoremap <Down> ddp

inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>

inoremap <backspace> <nop>
inoremap <delete> <nop>

"Extra functionality

"Typing
nnoremap <leader>U viwUe
inoremap <leader>U <esc>viwUea

" Maping to get out of insert mode? 'jk'

"Accessing files
"VIMRC
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <Leader>gf :ALENext<CR>
nnoremap <Leader>gb :ALEPrevious<CR>
nnoremap <Leader>sr :syntax sync fromstart<CR>

