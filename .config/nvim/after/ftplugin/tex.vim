se foldmethod=marker

"NORMAL mappings
nnoremap <buffer> <localleader>c :call <SID>compile()<cr>


"INSERT mappings
inoremap <leader>t \texttt{

inoremap <leader>be \begin{enumerate}<cr>
inoremap <leader>ee \end{enumerate}<cr>
inoremap <leader>i \item 

inoremap <leader>s \section{
inoremap <leader>ss \subsection{
inoremap <leader>sss \subsubsection{

"FUNCTIONS
let b:root_file = ''
function! s:compile()
  while !len(b:root_file) || !filereadable(b:root_file)
    let b:root_file = input('Enter root tex file path: ')
  endwhile

  echom 'Compiling ' . b:root_file
  execute '!pdflatex ' . b:root_file
  execute '!biber ' . b:root_file
  execute '!pdflatex ' . b:root_file
endfunction
