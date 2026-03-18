; ============================================================================
; Syntax highlighting queries for YTsaurus YQL (Zed Editor)
; ============================================================================

; ---------------------------------------------------------------------------
; Comments
; ---------------------------------------------------------------------------

(line_comment) @comment
(block_comment) @comment
(ansi_lexer_pragma) @comment

; ---------------------------------------------------------------------------
; Literals
; ---------------------------------------------------------------------------

(integer_literal) @number
(float_literal) @number

(single_quoted_string) @string
(double_quoted_string) @string
(multiline_string) @string

(bool_literal) @boolean
(null_literal) @constant.builtin

; ---------------------------------------------------------------------------
; Identifiers
; ---------------------------------------------------------------------------

(backtick_identifier) @string.special

; ---------------------------------------------------------------------------
; Keywords — anonymous token matching (via alias in grammar's kw() helper)
; ---------------------------------------------------------------------------

; DML / DQL
"SELECT" @keyword
"FROM" @keyword
"WHERE" @keyword
"GROUP" @keyword
"BY" @keyword
"HAVING" @keyword
"WINDOW" @keyword
"ORDER" @keyword
"LIMIT" @keyword
"OFFSET" @keyword
"UNION" @keyword
"INTERSECT" @keyword
"EXCEPT" @keyword
"ALL" @keyword
"DISTINCT" @keyword
"AS" @keyword
"INTO" @keyword
"RESULT" @keyword
"DISCARD" @keyword
"WITHOUT" @keyword
"VALUES" @keyword
"INSERT" @keyword
"REPLACE" @keyword

; JOIN
"JOIN" @keyword
"INNER" @keyword
"LEFT" @keyword
"RIGHT" @keyword
"FULL" @keyword
"OUTER" @keyword
"SEMI" @keyword
"ONLY" @keyword
"CROSS" @keyword
"EXCLUSION" @keyword
"ON" @keyword
"USING" @keyword
"ANY" @keyword

; DDL
"CREATE" @keyword
"TEMPORARY" @keyword
"TABLE" @keyword
"DROP" @keyword
"PRIMARY" @keyword
"KEY" @keyword

; Operators as keywords
"NOT" @keyword
"AND" @keyword
"OR" @keyword
"XOR" @keyword
"IN" @keyword
"BETWEEN" @keyword
"SYMMETRIC" @keyword
"ASYMMETRIC" @keyword
"LIKE" @keyword
"ILIKE" @keyword
"REGEXP" @keyword
"RLIKE" @keyword
"MATCH" @keyword
"ESCAPE" @keyword
"IS" @keyword
"DISTINCT" @keyword
"EXISTS" @keyword

; CASE expression
"CASE" @keyword
"WHEN" @keyword
"THEN" @keyword
"ELSE" @keyword
"END" @keyword

; CAST / BITCAST
"CAST" @keyword
"BITCAST" @keyword

; OVER / WINDOW spec
"OVER" @keyword
"PARTITION" @keyword
"ROWS" @keyword
"UNBOUNDED" @keyword
"PRECEDING" @keyword
"FOLLOWING" @keyword
"CURRENT" @keyword
"ROW" @keyword

; ORDER BY modifiers
"ASC" @keyword
"DESC" @keyword
"NULLS" @keyword
"FIRST" @keyword
"LAST" @keyword
"ASSUME" @keyword

; FLATTEN
"FLATTEN" @keyword
"COLUMNS" @keyword
"LIST" @keyword
"DICT" @keyword
"OPTIONAL" @keyword

; SAMPLE
"SAMPLE" @keyword
"TABLESAMPLE" @keyword
"BERNOULLI" @keyword
"SYSTEM" @keyword
"REPEATABLE" @keyword

; TABLE functions
"CONCAT" @keyword
"CONCAT_STRICT" @keyword
"EACH" @keyword
"EACH_STRICT" @keyword
"RANGE" @keyword
"RANGE_STRICT" @keyword
"FILTER" @keyword
"FILTER_STRICT" @keyword
"FOLDER" @keyword
"WalkFolders" @keyword

; WITH / VIEW / TABLE settings
"WITH" @keyword
"VIEW" @keyword
"AS_TABLE" @keyword

; ROLLUP / CUBE / GROUPING SETS
"ROLLUP" @keyword
"CUBE" @keyword
"SETS" @keyword

; Misc statements
"USE" @keyword
"PRAGMA" @keyword
"DECLARE" @keyword
"COMMIT" @keyword
"IF" @keyword

; DEFINE / DO / EVALUATE
"DEFINE" @keyword
"ACTION" @keyword
"SUBQUERY" @keyword
"DO" @keyword
"BEGIN" @keyword
"EVALUATE" @keyword
"FOR" @keyword
"RETURN" @keyword
"EMPTY_ACTION" @keyword

; EXPORT / IMPORT
"EXPORT" @keyword
"IMPORT" @keyword
"SYMBOLS" @keyword

; PROCESS / REDUCE
"PROCESS" @keyword
"REDUCE" @keyword
"PRESORT" @keyword

; Pseudo-functions as keywords
"TableRow" @keyword
"TableRows" @keyword
"GROUPING" @keyword
"SessionWindow" @keyword

; Pragma default value
"default" @keyword

; Boolean / null literals (override with @constant below)
"TRUE" @boolean
"FALSE" @boolean
"NULL" @constant.builtin

; Join type node (covers combined join keywords)
(join_type) @keyword
(commit_statement) @keyword

; ---------------------------------------------------------------------------
; Functions
; ---------------------------------------------------------------------------

; Module::Function — Module part (cyan for package name, blue for function)
(function_call
  function: (identifier (plain_identifier) @type) . "::" . (identifier (plain_identifier) @function))

; Special pseudo-functions
(table_row_call) @function
(table_rows_call) @function
(grouping_call) @function
(empty_action_literal) @function

; Table functions (CONCAT, EACH, RANGE, FILTER, FOLDER, etc.)
(table_function) @function

; SessionWindow
(session_window_call) @function

; Regular function call: function name
(function_call
  function: (identifier (plain_identifier) @function))

; Named expression used as function
(function_call
  function: (named_expression) @function)

; Window function (OVER expression) — window name
(over_expression
  window: (identifier (plain_identifier) @variable))



; ---------------------------------------------------------------------------
; Types
; ---------------------------------------------------------------------------

(simple_type
  (identifier (plain_identifier) @type))

(optional_type) @type
(list_type) @type
(dict_type) @type
(set_type) @type
(tuple_type) @type
(struct_type) @type
(variant_type) @type
(stream_type) @type
(callable_type) @type
(resource_type) @type
(tagged_type) @type
(enum_type) @type

; CAST / BITCAST target type
(cast_expression
  type: (type_expr) @type)
(bitcast_expression
  type: (type_expr) @type)

; ---------------------------------------------------------------------------
; Operators
; ---------------------------------------------------------------------------

(binary_expression operator: _ @operator)
(unary_expression operator: _ @operator)
(named_expr_assignment "=" @operator)

(asterisk) @operator

; ---------------------------------------------------------------------------
; Member / subscript access
; ---------------------------------------------------------------------------

(member_access
  object: (identifier (plain_identifier) @type))

(member_access
  member: (integer_literal) @property)

; Table alias before .* in SELECT (e.g. t.*)
(select_item
  (identifier (plain_identifier) @type) . "." . (asterisk))

; Table alias in WITHOUT column (e.g. t2.a)
(without_column
  (identifier (plain_identifier) @type) . "." . (identifier))

; ---------------------------------------------------------------------------
; Lambda
; ---------------------------------------------------------------------------

(lambda_expression) @function
(lambda_params (named_expression) @variable.parameter)
(lambda_body) @function

; Action / subquery parameters
(action_param (named_expression) @variable.parameter)

; ---------------------------------------------------------------------------
; DEFINE ACTION / DEFINE SUBQUERY names
; ---------------------------------------------------------------------------

(define_action_statement (named_expression) @function)
(define_subquery_statement (named_expression) @function)

; ---------------------------------------------------------------------------
; Table references
; ---------------------------------------------------------------------------

(table_ref
  alias: (identifier (plain_identifier) @type))

; Subquery / named-expression alias (inlined from _table_or_subquery)
(from_clause
  alias: (identifier (plain_identifier) @type))

(join_source
  alias: (identifier (plain_identifier) @type))

; ---------------------------------------------------------------------------
; Punctuation
; ---------------------------------------------------------------------------

"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

"," @punctuation.delimiter
";" @punctuation.delimiter
"." @punctuation.delimiter

(struct_literal "<|" @punctuation.bracket)
(struct_literal "|>" @punctuation.bracket)

; ---------------------------------------------------------------------------
; SQL hints
; ---------------------------------------------------------------------------

(sql_hint) @comment

(hint_entry
  (identifier (plain_identifier) @attribute))

; ---------------------------------------------------------------------------
; Named expression definitions
; ---------------------------------------------------------------------------

(named_expr_assignment
  (named_expression) @variable.special)

(declare_statement
  (named_expression) @variable.special)

(export_statement
  (named_expression) @variable.special)

(import_symbol
  (named_expression) @variable.special)

; General named expression fallback (must be last so specific rules above win)
(named_expression) @variable.special
