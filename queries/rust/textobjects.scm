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
        (visibility_modifier)?
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

(array_expression (_) @object.value . ","? @object.value) @object.outer
(array_expression ((_) @object.inner . ","? @object.inner)*)
