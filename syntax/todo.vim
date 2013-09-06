" File:        todo.txt.vim
" Description: Todo.txt syntax settings
" Author:      Leandro Freitas <freitass@gmail.com>
" Licence:     Vim licence
" Website:     http://github.com/freitass/todo.txt.vim
" Version:     0.3

if exists("b:current_syntax")
    finish
endif

syntax  match  TodoDone       '^[xX]\s.\+$'              contains=TodoDate,TodoProject,TodoContext,TodoDue,TodoNote
syntax  match  TodoPriorityA  '^([aA])\s.\+$'            contains=TodoDate,TodoProject,TodoContext,TodoDue,TodoNote
syntax  match  TodoPriorityB  '^([bB])\s.\+$'            contains=TodoDate,TodoProject,TodoContext,TodoDue,TodoNote
syntax  match  TodoPriorityC  '^([cC])\s.\+$'            contains=TodoDate,TodoProject,TodoContext,TodoDue,TodoNote
syntax  match  TodoPriorityX  '^([d-zD-Z])\s.\+$'            contains=TodoDate,TodoProject,TodoContext,TodoDue,TodoNote

syntax  match  TodoDate       '\d\{4\}-\d\{2\}-\d\{2\}'  contains=NONE
syntax  match  TodoProject    '+[[:alnum:]äöüÄÖÜß]\+'    contains=NONE
syntax  match  TodoContext    '@[[:alnum:]äöüÄÖÜß]\+'    contains=NONE
syntax  match  TodoDue        'due:\d\{4\}-\d\{2\}-\d\{2\}' contains=NONE
syntax  match  TodoNote	      'note:|[[:alnum:]äöüÄÖÜß]\+|' contains=NONE

" Other priority colours might be defined by the user
highlight  default  link  TodoDone       Comment
highlight  default  link  TodoPriorityA  Constant
highlight  default  link  TodoPriorityB  Statement
highlight  default  link  TodoPriorityC  Identifier
highlight  default  link  TodoPriorityX  Comment
highlight  default  link  TodoDate       PreProc
highlight  default  link  TodoProject    Special
highlight  default  link  TodoContext    Special
highlight  default  link  TodoDue        Underlined
highlight  default  link  TodoNote	 Comment

let b:current_syntax = "todo"
