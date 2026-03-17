; ============================================================================
; Indentation queries for YTsaurus YQL (Zed Editor)
; ============================================================================

; SELECT body indents its clauses
(select_body) @indent

; Parenthesized groups
(parenthesized_expression ")" @end) @indent
(subquery_expression ")" @end) @indent
(function_call ")" @end) @indent
(tuple_expression ")" @end) @indent
(values_row ")" @end) @indent

; Lambda body with braces
(lambda_body "}" @end) @indent

; Struct literal <| ... |>
(struct_literal "|>" @end) @indent

; List / dict literals
(list_literal "]" @end) @indent
(dict_literal "}" @end) @indent

; DEFINE ACTION ... END DEFINE
(define_action_statement) @indent

; DEFINE SUBQUERY ... END DEFINE
(define_subquery_statement) @indent

; DO BEGIN ... END DO
(begin_end_do_statement) @indent

; Inline action block
(inline_action) @indent

; EVALUATE IF / FOR blocks
(evaluate_if_statement) @indent
(evaluate_for_statement) @indent

; CASE ... END
(case_expression) @indent
(when_clause) @indent

; CREATE TABLE column definitions
(create_table_statement ")" @end) @indent

; Window spec
(window_definition ")" @end) @indent
