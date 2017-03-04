"=============================================================================
" Description: Perform a search using the command-line tool howdoi and 
" display the results in a scratch buffer.
" File: howdoi.vim
" Author: Vanessa McHale <tmchale@wisc.edu>
" Version: 0.1.0.0
" ChangeLog:
"       0.1.0.0: initial commit.
if exists("g:__HOWDOI_VIM__")
    finish
endif
let g:__HOWDOI_VIM__ = 1

if !exists("g:howdoi_num")
    let g:howdoi_num = 1
endif

if !exists("g:howdoi_options")
    let g:howdoi_options = ''
endif

let g:howdoi_buf_name = 'Howdoi'

if !exists("g:howdoi_buf_size")
    let g:howdoi_buf_size = 13
endif

" Mark a buffer as scratch
function! s:ScratchMarkBuffer()
    setlocal buftype=nofile
    " make sure buffer is deleted when view is closed
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal buflisted
    setlocal nonumber
    setlocal statusline=%F
    setlocal nofoldenable
    setlocal foldcolumn=0
    setlocal wrap
    setlocal linebreak
    setlocal nolist
endfunction

" Return the number of visual lines in the buffer
fun! s:CountVisualLines()
    let initcursor = getpos(".")
    call cursor(1,1)
    let i = 0
    let previouspos = [-1,-1,-1,-1]
    " keep moving cursor down one visual line until it stops moving position
    while previouspos != getpos(".")
        let i += 1
        " store current cursor position BEFORE moving cursor
        let previouspos = getpos(".")
        normal! gj
    endwhile
    " restore cursor position
    call setpos(".", initcursor)
    return i
endfunction

" return -1 if no windows was open
"        >= 0 if cursor is now in the window
fun! s:HowdoiGotoWin() "{{{
    let bufnum = bufnr( g:howdoi_buf_name )
    if bufnum >= 0
        let win_num = bufwinnr( bufnum )
        " Will return negative for already deleted window
        exe win_num . "wincmd w"
        return 0
    endif
    return -1
endfunction "}}}

" Close howdoi Buffer
fun! HowdoiClose() "{{{
    let last_buffer = bufnr("%")
    if s:HowdoiGotoWin() >= 0
        close
    endif
    let win_num = bufwinnr( last_buffer )
    " Will return negative for already deleted window
    exe win_num . "wincmd w"
endfunction "}}}

" Open a scratch buffer or reuse the previous one
fun! HowdoiFn(...) "{{{
    let last_buffer = bufnr("%")

    if s:HowdoiGotoWin() < 0
        new
        exe 'file ' . g:howdoi_buf_name
        setl modifiable
    else
        setl modifiable
        normal ggVGd
    endif

    call s:ScratchMarkBuffer()

    execute '.!howdoi -n ' . g:howdoi_num . ' '  . join(a:000,' ') . ' ' . g:howdoi_options
    setl nomodifiable
    
    let size = s:CountVisualLines()

    if size > g:howdoi_buf_size
        let size = g:howdoi_buf_size
    endif

    execute 'resize ' . size

    nnoremap <silent> <buffer> q <esc>:close<cr>

endfunction "}}}

command! -nargs=* Howdoi call HowdoiFn(<f-args>)
