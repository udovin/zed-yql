; ============================================================================
; Outline queries for YTsaurus YQL (Zed Editor)
;
; Provides code outline / symbol navigation for the editor sidebar.
; ============================================================================

; ---------------------------------------------------------------------------
; Named expression assignments: $x = expr
; ---------------------------------------------------------------------------

(named_expr_assignment
  (named_expression) @name) @item

; ---------------------------------------------------------------------------
; DECLARE $name AS Type
; ---------------------------------------------------------------------------

(declare_statement
  (named_expression) @name) @item

; ---------------------------------------------------------------------------
; DEFINE ACTION $name(...) AS ... END DEFINE
; ---------------------------------------------------------------------------

(define_action_statement
  (named_expression) @name
  (#set! item.annotation "action")) @item

; ---------------------------------------------------------------------------
; DEFINE SUBQUERY $name(...) AS ... END DEFINE
; ---------------------------------------------------------------------------

(define_subquery_statement
  (named_expression) @name
  (#set! item.annotation "subquery")) @item

; ---------------------------------------------------------------------------
; SELECT statement — show INTO RESULT label or just "SELECT"
; ---------------------------------------------------------------------------

(into_result_clause
  (identifier) @name) @item

; ---------------------------------------------------------------------------
; INSERT INTO table
; ---------------------------------------------------------------------------

(insert_statement
  (backtick_identifier) @name
  (#set! item.annotation "insert")) @item

(insert_statement
  (identifier (plain_identifier) @name)
  (#set! item.annotation "insert")) @item

; ---------------------------------------------------------------------------
; REPLACE INTO table
; ---------------------------------------------------------------------------

(replace_statement
  (backtick_identifier) @name
  (#set! item.annotation "replace")) @item

(replace_statement
  (identifier (plain_identifier) @name)
  (#set! item.annotation "replace")) @item

; ---------------------------------------------------------------------------
; CREATE TABLE
; ---------------------------------------------------------------------------

(create_table_statement
  (backtick_identifier) @name
  (#set! item.annotation "table")) @item

(create_table_statement
  (identifier (plain_identifier) @name)
  (#set! item.annotation "table")) @item

; ---------------------------------------------------------------------------
; DROP TABLE
; ---------------------------------------------------------------------------

(drop_table_statement
  (backtick_identifier) @name
  (#set! item.annotation "drop table")) @item

(drop_table_statement
  (identifier (plain_identifier) @name)
  (#set! item.annotation "drop table")) @item

; ---------------------------------------------------------------------------
; IMPORT ... SYMBOLS
; ---------------------------------------------------------------------------

(import_statement
  (identifier (plain_identifier) @name)) @item

; ---------------------------------------------------------------------------
; EXPORT $symbols
; ---------------------------------------------------------------------------

(export_statement
  (named_expression) @name) @item

; ---------------------------------------------------------------------------
; USE cluster
; ---------------------------------------------------------------------------

(use_statement
  (identifier (plain_identifier) @name)) @item

; ---------------------------------------------------------------------------
; PRAGMA key = value
; ---------------------------------------------------------------------------

(pragma_statement
  (identifier (plain_identifier) @name)) @item
