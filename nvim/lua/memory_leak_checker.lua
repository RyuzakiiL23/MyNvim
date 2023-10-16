-- memory_leak_checker.lua

local M = {}

function M.setup()
  -- Initialization code for the plugin, if needed
end

function M.check_memory_leaks()
  -- Save the buffer
  vim.cmd("w")

  local filename = vim.fn.expand("%:t") -- Only the filename without the full path
  if vim.fn.filereadable(filename) == 1 then
    local valgrind_cmd = "valgrind --leak-check=full -q ./a.out " .. filename
    local output = vim.fn.system(valgrind_cmd .. " 2>&1")
    local lines = vim.split(output, "\n")

    local buffer_number = vim.fn.bufnr() -- Get the current buffer number
    local namespace_id = vim.api.nvim_create_namespace("memory_leak_checker")

    -- Clear existing signs and virtual text in the namespace
    vim.fn.sign_unplace("MemoryLeak", { buffer = buffer_number })
    vim.api.nvim_buf_clear_namespace(buffer_number, namespace_id, 0, -1)

    vim.fn.sign_define("MemoryLeak", { text = "", texthl = "ErrorMsg" })
    local is_leak_report = false
    for _, line in ipairs(lines) do
      if not is_leak_report and string.match(line, "ERROR SUMMARY: 0 errors") then
        break -- No memory leaks found
      elseif string.match(line, "LEAK SUMMARY:") then
        is_leak_report = true
      elseif is_leak_report and string.match(line, "definitely lost:") then
        vim.fn.sign_place(0, "MemoryLeak", "MemoryLeak", filename, { lnum = 1, priority = 10 })
        vim.api.nvim_buf_set_virtual_text(buffer_number, namespace_id, 0, { { line, "ErrorMsg" } }, {})
        break
      end
    end
  end
end

return M
