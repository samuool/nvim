-- do :call doge#install() to finish install this plugin adds automatic doc comment generation for existing functions <Leader>d to generate doc comments
return {
    "kkoomen/vim-doge",
    config = function ()
        vim.g.doge_javascript_settings = {
            destructuring_props= 1,
            omit_redundant_param_types= 1
        }
    end
}
