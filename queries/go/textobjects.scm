; extends
((interpreted_string_literal) @quote.outer)
((raw_string_literal) @quote.outer)
(( interpreted_string_literal ) (interpreted_string_literal_content) @quotes.inner)
((raw_string_literal)(raw_string_literal_content) @quote.inner)
