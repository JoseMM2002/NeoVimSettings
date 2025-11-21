; inherits: typescript

(jsx_element open_tag: (jsx_opening_element
   name: (identifier) @object.type
) @object.outer)

(jsx_self_closing_element
    name: (identifier) @object.type 
) @object.outer
(jsx_attribute)* @object.inner

(jsx_attribute
    (property_identifier) @object.key
    .
    (_) @object.value
) @object.field
