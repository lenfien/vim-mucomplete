" Chained completion that works as I want!
" Maintainer: Lifepillar <lifepillar@lifepillar.me>
" License: This file is placed in the public domain

if exists("g:loaded_mucomplete")
  finish
endif
let g:loaded_mucomplete = 1

let s:save_cpo = &cpo
set cpo&vim

imap <expr> <silent> <plug>(MUcompleteCycFwd) mucomplete#cycle( 1)
imap <expr> <silent> <plug>(MUcompleteCycBwd) mucomplete#cycle(-1)
imap <expr> <silent> <plug>(MUcompleteFwd) mucomplete#tab_complete( 1)
imap <expr> <silent> <plug>(MUcompleteBwd) mucomplete#tab_complete(-1)

if !get(g:, 'mucomplete#no_mappings', get(g:, 'no_plugin_maps', 0))
  if !hasmapto('<plug>(MUcompleteFwd)', 'i')
    imap <unique> <tab> <plug>(MUcompleteFwd)
  endif
  if !hasmapto('<plug>(MUcompleteBwd)', 'i')
    imap <unique> <s-tab> <plug>(MUcompleteBwd)
  endif
  if !hasmapto('<plug>(MUcompleteCycFwd)', 'i')
    inoremap <silent> <plug>(MUcompleteFwdKey) <c-j>
    imap <unique> <c-j> <plug>(MUcompleteCycFwd)
  endif
  if !hasmapto('<plug>(MUcompleteCycBwd)', 'i')
    inoremap <silent> <plug>(MUcompleteBwdKey) <c-h>
    imap <unique> <c-h> <plug>(MUcompleteCycBwd)
  endif
endif

if has('patch-7.4.775') " noinsert was added there
  if !exists(":MUcompleteAutoOn")
    command -bar -nargs=0 MUcompleteAutoOn call mucomplete#enable_auto()
  endif

  if !exists(":MUcompleteAutoOff")
    command -bar -nargs=0 MUcompleteAutoOff call mucomplete#disable_auto()
  endif

  if !exists(":MUcompleteAutoToggle")
    command -bar -nargs=0 MUcompleteAutoToggle call mucomplete#toggle_auto()
  endif

  if get(g:, 'mucomplete#enable_auto_at_startup', 0)
    MUcompleteAutoOn
  endif
endif

let &cpo = s:save_cpo
unlet s:save_cpo
