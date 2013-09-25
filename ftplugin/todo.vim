" File:        todo.txt.vim
" Description: Todo.txt filetype detection
" Author:      Leandro Freitas <freitass@gmail.com>,
"              Andreas Wagner <andreas.wagner@em.uni-frankfurt.de>
" Licence:     Vim licence
" Website:     http://github.com/awagner-mainz/todo.txt.vim
" Version:     0.5

" Save context {{{1
let s:save_cpo = &cpo
set cpo&vim

" General options {{{1
" Some options lose their values when window changes. They will be set every
" time this script is invocated, which is whenever a file of this type is
" created or edited.
setlocal textwidth=0
setlocal wrapmargin=0
setlocal nowrap

" Mappings {{{1
" Sort tasks with \SD or \SP (on date or prio) {{{2

" SortDate(): Sort on dueDate (then on Priority) {{{3
" - bring entries with due: to the top,
" - bring entries beginnning with x to the bottom,
" - sort entries with dueDate: on Prio
" - sort entries with dueDate: on dueDate
" - sort (unfinished) entries without dueDate: on Prio
func SortDate()
    sort! r /due:/
    sort r /^x /
    0,/^\(.*due:\)\@!/-1sort r /^.../
    0,/^\(.*due:\)\@!/-1sort r /due:....-..-../
    0;/^\(.*due:\)\@!/,/^x /-1sort r /^.../
endfunc

" SortPrio(): Sort on Priority (then on dueDate) {{{3
" - bring entries with due: to the top
" - Sort on Prio
" - Sort within priorities on dueDate
func SortPrio()
    sort! r /due:/
    sort r /^.../
    0;/(A).*due:/,/(A)\(.*due:\)\@!/-1sort r /due:....-..-../
    0;/(B).*due:/,/(B)\(.*due:\)\@!/-1sort r /due:....-..-../
    0;/(C).*due:/,/(C)\(.*due:\)\@!/-1sort r /due:....-..-../
    0;/(D).*due:/,/(D)\(.*due:\)\@!/-1sort r /due:....-..-../
"    0;/^2.*due:/,/^2\(.*due:\)\@!/-1sort /due:/
endfunc

" Map the fnuctions to <leader>SD and <leader>SP. {{{3
if !hasmapto("<leader>SD",'n')	" avoid mapping to something that is already
				" part of another mapping's {rhs}
    nnoremap <silent> <buffer>	<leader>SD	:call SortDate()<CR>
endif

if !hasmapto("<leader>SP",'n')	" avoid mapping to something that is already
				" part of another mapping's {rhs}
    nnoremap <silent> <buffer>	<leader>SP	:call SortPrio()<CR>
endif


" Insert date with \d (or date<tab> in insert and visual modes) {{{2
if !hasmapto("<leader>d",'n')
    nnoremap <silent> <buffer>	<leader>d   "=strftime("%Y-%m-%d")<CR>P
endif

if !hasmapto("date<Tab>",'i')
    inoremap <silent> <buffer>	date<Tab>   <C-R>=strftime("%Y-%m-%d")<CR>
endif

if !hasmapto("<leader>d",'v')
    vnoremap <silent> <buffer>	<leader>d   c<C-R>=strftime("%Y-%m-%d")<CR><Esc>
endif

" Mark done with \D {{{2
if !hasmapto("<leader>D",'n')
    nnoremap <silent> <buffer>  <leader>D	Ix  <ESC>"=strftime("%Y-%m-%d")<CR>P
endif

" Folding {{{1
" Options {{{2
setlocal foldmethod=expr
setlocal foldexpr=TodoFoldLevel(v:lnum)
setlocal foldtext=TodoFoldText()

" TodoFoldLevel(lnum) {{{2
function! TodoFoldLevel(lnum)
    " The match function returns the index of the matching pattern or -1 if
    " the pattern doesn't match. In this case, we always try to match a
    " completed task from the beginning of the line so that the matching
    " function will always return -1 if the pattern doesn't match or 0 if the
    " pattern matches. Incrementing by one the value returned by the matching
    " function we will return 1 for the completed tasks (they will be at the
    " first folding level) while for the other lines 0 will be returned,
    " indicating that they do not fold.
    return match(getline(a:lnum),'^[xX]\s.\+$') + 1
endfunction

" TodoFoldText() {{{2
function! TodoFoldText()
    " The text displayed at the fold is formatted as '+- N Completed tasks'
    " where N is the number of lines folded.
    return '+' . v:folddashes . ' '
                \ . (v:foldend - v:foldstart + 1)
                \ . ' Completed tasks '
endfunction

" Restore context {{{1
let &cpo = s:save_cpo
" Modeline {{{1
" vim: ts=8 sw=4 sts=4 et foldenable foldmethod=marker foldcolumn=1
