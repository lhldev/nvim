require("lhl.remap")
require("lhl.set")

vim.cmd [[
  function! RunCurrentFile()
    let l:filename = expand('%:p')  " Get the full path of the current file
    let l:extension = expand('%:e')  " Get the file extension
    let l:outPath = expand('%:p:r')

    execute 'wa'

    if l:extension == 'rs'
        let l:manifestPath = expand('%:p:h:h') . "/Cargo.toml" " Go :h:h go back two file
        call RunInTerminal('cargo run --manifest-path "' . l:manifestPath . '"')
    elseif l:extension == 'c' || l:extension == 'cpp' || l:extension == 'h' || l:extension == 'hpp'
        call RunInTerminal('make -C build run')
    elseif l:extension == 'html'
        execute 'lua LiveServer()'
        execute '!explorer.exe http://localhost:8080'
    else
        echo "No run command defined for this file type."
    endif
  endfunction

  function! RunCTest()
    call RunInTerminal('ctest --output-on-failure --test-dir build')
  endfunction

  function! RunInTerminal(cmd)
    execute 'botright split | term ' . a:cmd
    startinsert
  endfunction
]]

local job_id

function LiveServer()
    if job_id then
        print('Live Server already running')
        return
    end

    local cmd = {'live-server', vim.fn.expand('%:h')}

    job_id = vim.fn.jobstart(cmd, {
        on_stderr = function(_, data)
            if not data or data[1] == '' then
                return
            end

            print('Error: ' .. data[1])
        end,
        on_exit = function(_, exit_code)
            job_id = nil
             -- instance killed with SIGTERM
            if exit_code == 143 then
                return
            end

            print(string.format('Live Server stopped with code %s', exit_code))
        end,
    })

    if job_id > 0 then
        print('Live Server started with job ID: ' .. job_id)
    else
        print('Failed to start Live Server')
    end
end

function ToggleComment()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    local extension = vim.fn.expand('%:e')

    local comment_leader

    if extension == 'c' or extension == 'cpp' or extension == 'h' or extension == 'hpp' or extension == 'rs' or extension == 'js' then
        comment_leader = "// "
    elseif extension == 'lua' then
        comment_leader = "-- "
    else
        vim.api.nvim_out_write("Auto commenting not suported for this file type!\n")
        return
    end

    for line_num = start_line, end_line do
        local line = vim.fn.getline(line_num)

        if line:match("^%s*$") then
            -- skip
        elseif line:match("^%s*" .. vim.pesc(comment_leader)) then
            line = line:gsub("^(%s*)" .. vim.pesc(comment_leader), "%1")
        else
            -- comment it
            line = line:gsub("^(%s*)", "%1" .. comment_leader)
        end

        vim.fn.setline(line_num, line)
    end
end

function IndentForward()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    for line_num = start_line, end_line do
        local line = vim.fn.getline(line_num)

        if not line:match("^%s*$") then
            line = "\t" .. line
        end

        vim.fn.setline(line_num, line)
    end

    vim.fn.cursor(start_line, 1)
    vim.cmd('normal! v')
    vim.fn.cursor(end_line, #vim.fn.getline(end_line) + 1)
end

function IndentBackward()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local tab_width = vim.o.tabstop

    for line_num = start_line, end_line do
        local line = vim.fn.getline(line_num)

        if line:match("^\t") then
            line = line:sub(2)
        elseif line:match("^%s") then
            local space_count = #line:match("^%s+")
            local spaces_to_remove = math.min(tab_width, space_count)
            line = line:sub(spaces_to_remove + 1)
        end

        vim.fn.setline(line_num, line)
    end

    vim.fn.cursor(start_line, 1)
    vim.cmd('normal! v')
    vim.fn.cursor(end_line, #vim.fn.getline(end_line) + 1)
end
