(quoted_attribute_value (attribute_value) @quote.inner) @quote.outer

(start_tag
    (tag_name) @object.type
    (attribute
        (attribute_name) @object.key
        (quoted_attribute_value)? @object.value
    )? @object.field
) @object.outer

(self_closing_tag
    (tag_name) @object.type
    (attribute
        (attribute_name) @object.key
        (quoted_attribute_value)? @object.value
    )? @object.field
) @object.outer

(directive_attribute
    (directive_value) @object.key
    (quoted_attribute_value) @object.value
) @object.field
