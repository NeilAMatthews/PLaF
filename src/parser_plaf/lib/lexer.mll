(* Lexer definitions for ocamllex 
   E.B. 
*)


(* Header: 
   This code is copied to the output file 
*)
{
open Grammar   (* module generated by menhir from grammar.mly *)

exception Error of string
}

(* Identifiers used in the rules *)

let whitespace_char_no_newline = [' ' '\t' '\012' '\r']+
let digit = ['0'-'9']
let int = digit digit*
let letter = ['a'-'z' 'A'-'Z']
let id = letter ['a'-'z' 'A'-'Z' '0'-'9' '_' '?']*

(* Entry points:
   read, comment *)

rule read =
  parse
  | whitespace_char_no_newline    { read lexbuf }
  | '\n'      { Lexing.new_line lexbuf; read lexbuf }
  | "(*"      { comment lexbuf; read lexbuf } (* activate "comment" rule *)                 
  | int       { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | "+"       { PLUS }
  | "-"       { MINUS }
  | "*"       { TIMES }
  | "/"       { DIVIDED }
  | "("       { LPAREN }
  | ")"       { RPAREN }
  | "{"       { LBRACE }
  | "}"       { RBRACE }
  | "<"       { LANGLE }
  | ">"       { RANGLE }
  | "<<"      { LLANGLE }
  | ">>"      { RRANGLE }
  | ";"       { SEMICOLON }
  | ":"       { COLON }
  | ","       { COMMA }
  | "."       { DOT }
  | "abs"     { ABS }
  | "min"     { MIN }
  | "sum"     { SUM }
  | "prod"    { PROD }
  | "avg"     { AVG }
  | "maxl"    { MAXL }
  | "let"     { LET }
  | "="       { EQUALS }
  | "<="      { EQUALSMUTABLE }
  | "in"      { IN }
  | "proc"    { PROC }
  | "zero?"   { ISZERO }
  | "number?" { ISNUMBER }
  | "if"      { IF }
  | "then"    { THEN }
  | "else"    { ELSE }
  | "letrec"  { LETREC }
  | "set"     { SET }
  | "begin"   { BEGIN }
  | "end"     { END }
  | "newref"  { NEWREF }
  | "deref"   { DEREF }
  | "setref"  { SETREF }
  | "debug"   { DEBUG }
  | "fst"     { FST }
  | "snd"     { SND }
  | "pair"    { PAIR }
  | "unpair"  { UNPAIR }
  | "emptylist" { EMPTYLIST }
  | "mklist"  { MKLIST }
  | "cons"    { CONS }
  | "hd"      { HD }
  | "tl"      { TL }
  | "emptytree" { EMPTYTREE }
  | "node"      { NODE }
  | "caseT"     { CASET }
  | "->"        { ARROW }  
  | "of"        { OF }
  | "send"    { SEND }
  | "class"   { CLASS }
  | "super"   { SUPER }
  | "extends" { EXTENDS }
  | "method"  { METHOD }
  | "field"   { FIELD }
  | "self"    { SELF }
  | "new"     { NEW }
  | "empty?"   { ISEMPTY }
  | "implements"  { IMPLEMENTS }
  | "instanceof?"  { INSTANCEOF }
  | "interface"  { INTERFACE }
  | "cast"   { CAST }
  (* types *)
  | "int"    { INTTYPE }
  | "bool"   { BOOLTYPE }
  | "unit"   { UNITTYPE }
  | "ref"    { REFTYPE }
  | "list"   { LISTTYPE }
  | "tree"   { TREETYPE }
  | "sett"   { SETTYPE }
  | "stack"  { STACKTYPE }
  | "queue"  { QUEUETYPE }
  | "htbl"   { HTBLTYPE }
  (* stacks *)
  | "emptystack"   { EMPTYSTACK }
  | "push"   { PUSH }
  | "pop"   { POP }
  | "top"   { TOP }
  | "size"   { SIZE }
  (* sets *)
  | "mkset"       { MKSET }
  | "emptyset"    { EMPTYSET }
  | "insertset"   { INSERTSET }
  | "unionset"    { UNIONSET }
  | "subset?"     { ISSUBSET }
  | "member?"     { ISMEMBER }
  (* queues *)
  | "emptyqueue"    { EMPTYQUEUE }
  | "addq"       { ADDQ }
  | "removeq"    { REMOVEQ }
  | "topq"   { TOPQ }
  (* queues *)
  | "emptyhtbl"    { EMPTYHTBL }
  | "inserthtbl"   { INSERTHTBL }
  | "lookuphtbl"   { LOOKUPHTBL }
  | "removehtbl"   { REMOVEHTBL }
  | id       { ID (Lexing.lexeme lexbuf) }
  | eof      { EOF }
  | _
      { raise (Error (Printf.sprintf
                        "At offset %d: unexpected character."
                        (Lexing.lexeme_start lexbuf))) }
and
  comment = parse
  | "*)" { () }
  | '\n'     { Lexing.new_line lexbuf; comment lexbuf }
  | eof  { failwith "unterminated comment" }
  | _    { comment lexbuf }  (* skip comments *)
