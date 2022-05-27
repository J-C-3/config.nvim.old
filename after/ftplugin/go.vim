" runtime after/ftplugin/go.lua
packadd go.nvim

autocmd BufWritePre *.go GoImport
" autocmd BufWritePre *.go,go.mod lua vim.lsp.buf.formatting_sync(nil, 1000)
" autocmd BufWritePre *.go,go.mod GoFmt " Don't do this. go.nvim does it
" itself so if you gofmt, it'll gofmt as a pre-write action, which will 
" make yours gofmt again cause it has to do it before write and thus
" recursive loop to hell

" autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
autocmd BufEnter *.go nmap <leader>Gfs :GoFillStruct<cr>
autocmd BufEnter *.go nmap <leader>Gie :GoIfErr<cr>

" GoRun equal to *.go run .; or GoRun ./cmd equal to go run ./cmd
autocmd BufEnter *.go nmap <leader>Gr  :GoRun

" go test ./... -tags=yourtags
autocmd BufEnter *.go nmap <leader>Gt  :GoTest
autocmd BufEnter *.go nmap <leader>Gat :GoAddTest<cr>

function GoRunQf()
    cex system("go run . | grep ':.*:'")
endfunction

autocmd FileType go nmap <silent> <leader>Gr :call GoRunQf()<cr>
"
"     " Go Debug mappings
"     " key	Description
"     " c	continue
"     " n	next
"     " s	step
"     " o	stepout
"     " S	cap S: stop debug
"     " u	up
"     " D	cap D: down
"     " C	cap C: run to cursor
"     " b	toggle breakpoint
"     " P	cap P: pause
"     " p	print, hover value (also in visual mode)
