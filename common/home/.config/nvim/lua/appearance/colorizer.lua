if IsDiff() then
  return
end

-- color detection (painting hex colors)
local color_detection_ok, color_detection = pcall(require, "colorizer")
if not color_detection_ok then
    vim.notify("color detection " .. color_detection .. " not found!")
    return
end

color_detection.setup {
    'css',
    'scss',
    'sass',
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    html = {
        mode = 'foreground',
    }
}
