; extends
((string_literal) @quote.outer)
((raw_string_literal) @quote.outer)
((string_content) @quote.inner)

(struct_expression name: (_) @object.type)
(field_initializer_list) @object.outer
(
    (field_initializer
        field: (_) @object.key
        value: (_) @object.value
    ) @object.field
    .
    ","? @object.field
)
(field_initializer_list ((_) @object.inner ","? @object.inner)*)

(struct_item name: (_) @object.type)
(field_declaration_list
    (field_declaration
        (visibility_modifier)? @object.scope
        .
        name: (_) @object.key
        type: (_) @object.value
    ) @object.field
    .
    ","? @object.field
) @object.outer
(field_declaration_list
    ((field_declaration) @object.inner
    .
    ","? @object.inner)*
)

(enum_item
    name: (type_identifier) @object.type
    body: (
        enum_variant_list
        (enum_variant) @object.value
        .
        ","? @object.value
        .
        (line_comment)? @object.value
    ) @object.outer
)

(array_expression (_) @object.value . ","? @object.value) @object.outer
(array_expression ((_) @object.inner . ","? @object.inner)*)

(ordered_field_declaration_list 
    (visibility_modifier)? @object.value 
    .
    type: (_) @object.value 
    . 
    ","? @object.value
) @object.outer
(ordered_field_declaration_list ((_) @object.inner . ","? @object.inner)*)

(let_declaration
    pattern: (_) @set.lhs
    type: (_)? @set.type
    value: (_)? @set.rhs
) @set.outer
(assignment_expression
    left: (_) @set.lhs
    right: (_) @set.rhs
) @set.outer
(type_item
    name: (type_identifier) @set.lhs
    type: (_) @set.rhs
) @set.outer

(arguments ((_) @param.inner @param.outer ","? @param.outer))
(parameters 
    (parameter
        type: (_) @param.type
    ) @param.inner @param.outer
    .
    ","? @param.outer
)
(closure_expression
    parameters: (closure_parameters
        (parameter
            type: (_) @param.type
        ) @param.inner @param.outer
        .
        ","? @param.outer
    )
    body: (block (_)* @function.inner) 
) @function.outer
(generic_type
    type_arguments: (
        (type_arguments
            (_) @param.inner @param.outer
            .
            ","? @param.outer
        )
    )
) @call.outer
(generic_type
    type_arguments: (
        (type_arguments
            ((_) @call.inner
            .
            ","? @call.inner
            )*
        )
    )
)
