set foldmethod=marker
set iskeyword+=\

"NORMAL mappings
nnoremap <buffer> <localleader>c :call <SID>compile()<cr>


"ABBREVIATIONS
inoreabbrev \t \texttt
inoreabbrev \i \item 

inoreabbrev \s \section
inoreabbrev \ss \subsection
inoreabbrev \sss \subsubsection

inoreabbrev \be \begin{enumerate}<cr>
inoreabbrev \ee \end{enumerate}<cr>

inoreabbrev \bu \begin{usrstory}<cr>
inoreabbrev \eu \end{usrstory}<cr>

inoreabbrev \bg \begin{goal}<cr>
inoreabbrev \eg \end{goal}<cr>

inoreabbrev \refsec Section~\ref
inoreabbrev \reffig Figure~\ref



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
