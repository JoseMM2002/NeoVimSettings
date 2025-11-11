; extends
((interpreted_string_literal) @quote.outer)
((raw_string_literal) @quote.outer)
((interpreted_string_literal) (interpreted_string_literal_content) @quotes.inner)
((raw_string_literal)(raw_string_literal_content) @quote.inner)

(composite_literal (literal_value) @object.outer) 
(composite_literal
    (literal_value
        (keyed_element
            key: (_) @object.key
            value: (_) @object.value
        ) @object.field
        .
        ","? @object.field
    )
)
(composite_literal
    (literal_value
        (literal_element) @object.value
        .
        ","? @object.value
    )
)
(composite_literal
    (literal_value
        ((keyed_element) @object.inner
        .
        ","? @object.inner
        )*
    )
)
(composite_literal
    (literal_value
        ((literal_element) @object.inner
        .
        ","? @object.inner
        )*
    )
)

(type_spec name: (_) @object.type)
(field_declaration_list) @object.outer
(field_declaration_list
    (field_declaration
        name: (_) @object.key
        type: (_) @object.value
    ) @object.field
    .
    (comment)? @object.field
)
(field_declaration_list
    ((field_declaration) @object.inner
    .
    (comment)? @object.inner)*
)

(var_spec name:(_) @set.lhs value: (_) @set.rhs) @set.outer
(short_var_declaration left: (_) @set.lhs right: (_) @set.rhs) @set.outer
(assignment_statement left: (_) @set.lhs right: (_) @set.rhs) @set.outer

(argument_list
    (_) @param.inner @param.outer
    .
    ","? @param.outer
)
(parameter_list
    (_) @param.inner @param.outer
    .
    ","? @param.outer
)
