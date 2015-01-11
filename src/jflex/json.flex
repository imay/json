// Json Jflex 
package com.github.imay.json

%%

// Name of generated code
%class JsonScanner
// Make class public
%public
// switches to CUP compatibility mode to interface with a CUP generated parser
%cup
// unicode
%unicode
// switches line counting on 
%line
// switches column counting on 
%column

%{
%}

StringLiteral = \"(\\.|[^\\\"])*\"

Number1 = [+-]? 0
Number2 = [+-]? [1-9] [0-9]*
Number3 = \. [0-9]+
Exponent = [eE] [+-]? [0-9]+
NumberLiteral = ({Number1} | {Number2}) {Number3}? {Exponent}?

%%

":" { return newToken(JsonSymbols.COLON, null); }
"," { return newToken(JsonSymbols.COMMA, null); }
"{" { return newToken(JsonSymbols.LBRACE, null); }
"}" { return newToken(JsonSymbols.RBRACE, null); }
"[" { return newToken(JsonSymbols.LBRACKET, null); }
"]" { return newToken(JsonSymbols.RBRACKET, null); }
"true" { return newToken(JsonSymbols.TRUE, null); }
"false" { return newToken(JsonSymbols.FALSE, null); }
"null" { return newToken(JsonSymbols.NULL, null); }

{NumberLiteral} {
}

{StringLiteral} {
}
