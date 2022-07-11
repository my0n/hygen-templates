---
to: <%= project %>/.editorconfig
---
[*.cs]
indent_style = space
indent_size = 4
csharp_space_between_method_call_parameter_list_parentheses = false
csharp_style_var_elsewhere = true:suggestion
csharp_style_namespace_declarations=file_scoped:silent

[*.{yml,yaml,json}]
indent_style = space
indent_size = 2
