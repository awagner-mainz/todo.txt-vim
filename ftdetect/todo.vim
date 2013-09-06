" File:        todo.txt.vim
" Description: Todo.txt filetype detection
" Author:      Leandro Freitas <freitass@gmail.com>
" Licence:     Vim licence
" Website:     http://github.com/freitass/todo.txt.vim
" Version:     0.1

autocmd BufNewFile,BufRead [Tt]odo.txt  set filetype=todo
autocmd BufNewFile,BufRead [Dd]one.txt  set filetype=todo
autocmd BufNewFile,BufRead [Rr]ecur.txt set filetype=todo

