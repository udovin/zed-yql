; ============================================================================
; Bracket matching queries for YTsaurus YQL (Zed Editor)
; ============================================================================

("(" @open ")" @close)
("[" @open "]" @close)
("{" @open "}" @close)

(struct_literal "<|" @open "|>" @close)
