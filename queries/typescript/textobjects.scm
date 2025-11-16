;; queries/typescript/textobjects.scm
; extends
(template_string ((string_fragment)? @quote.inner . (template_substitution)? @quote.inner)*) @quote.outer
(string (string_fragment) @quote.inner) @quote.outer

(object) @object.outer
(object
    (pair
        key: (_) @object.key
        value: (_) @object.value
    ) @object.field
    ","? @object.field
)
(object ((_) @object.inner ","? @object.inner)*)

(array ((_) @object.inner . ","? @object.inner)*)
(array ((_) @object.value . ","? @object.value)) @object.outer

(object_type
    (property_signature
        name: (_) @object.key
        type: (_) @object.value
    ) @object.field
    .
    ";"? @object.field
)
(type_alias_declaration  
  name: (type_identifier) @object.type
  value: (_) @object.outer
)
(object_type ((_) @object.inner ";"? @object.inner)*)

(type_arguments (_) @param.inner @param.outer . ","? @param.outer)
(arguments (_) @param.inner @param.outer . ","? @param.outer)
(formal_parameters (required_parameter
    type: (_) @param.type
) @param.inner @param.outer . ","? @param.outer)

(ternary_expression condition: (_) @conditional.inner) @conditional.outer

(assignment_expression
    left: (_) @set.lhs
    right: (_) @set.rhs
) @set.outer
(variable_declarator
    name: (_) @set.lhs
    type: (type_annotation (_)? @set.type)?
    value: (_)? @set.rhs
) @set.outer
(type_alias_declaration
    name: (_) @set.lhs
    value: (_) @set.rhs
) @set.outer
