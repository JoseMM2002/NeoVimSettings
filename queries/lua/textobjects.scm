;; queries/lua/textobjects.scm
; extends
((string) @quote.outer)
((string_content) @quote.inner)

(table_constructor) @object.outer
(table_constructor (","? @object.inner (_) @object.inner)*)
(table_constructor  (field) @object.field . ","? @object.field . (comment)? @object.field)
(table_constructor
    (field
        name: (_) @object.key
        value: (_) @object.value
    ) @object.field 
    .
    ","? @object.field
    (comment)? @object.field
)
(arguments (_) @param.inner @param.outer ","? @param.outer)
(parameters (_) @param.inner @param.outer ","? @param.outer)

(assignment_statement) @set.outer
(assignment_statement
    (variable_list) @set.lhs @set.inner
    (expression_list) @set.rhs @set.inner
)
