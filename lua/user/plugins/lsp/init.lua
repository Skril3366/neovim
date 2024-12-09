local path = "user.plugins.lsp." -- TODO: refactor and make dynamically loaded

local load_module = function(name)
  return require(path .. name)
end

local load_server = function(name)
  return require(path .. "servers." .. name)
end

return {
  -- get current module path
  -- load_module("dap"),
  load_module("mason"),
  load_module("null_ls"),
  load_module("java"),
  load_server("scala"),
  load_server("rust"),
  load_server("haskell"),
  -- load("lsp"),
}
