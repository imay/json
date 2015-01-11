// Json Jflex 
package com.github.imay.json;

import java_cup.runtime.Symbol;

%%

// Name of generated code
%class JsonScanner
// Make class public
%public
%final
// Use JsonParser EOF
%eofval{
    return newToken(JsonParserSymbols.EOF, null);
%eofval}
// switches to CUP compatibility mode to interface with a CUP generated parser
%cup
// unicode
%unicode
// switches line counting on 
%line
// switches column counting on 
%column

%{

    private Symbol newToken(int id, Object value) {
        return new Symbol(id, yyline+1, yycolumn+1, value);
    }

%}

StringLiteral = \"(\\.|[^\\\"])*\"

Number1 = [+-]? 0
Number2 = [+-]? [1-9] [0-9]*
Number3 = \. [0-9]+
Exponent = [eE] [+-]? [0-9]+
NumberLiteral = ({Number1} | {Number2}) {Number3}? {Exponent}?

%%

":" { return newToken(JsonParserSymbols.COLON, null); }
"," { return newToken(JsonParserSymbols.COMMA, null); }
"{" { return newToken(JsonParserSymbols.LBRACE, null); }
"}" { return newToken(JsonParserSymbols.RBRACE, null); }
"[" { return newToken(JsonParserSymbols.LBRACKET, null); }
"]" { return newToken(JsonParserSymbols.RBRACKET, null); }
"true" { return newToken(JsonParserSymbols.TRUE, null); }
"false" { return newToken(JsonParserSymbols.FALSE, null); }
"null" { return newToken(JsonParserSymbols.NULL, null); }

{NumberLiteral} {
    return newToken(JsonParserSymbols.NUMBER_LITERAL, yytext());
}

{StringLiteral} {
    return newToken(JsonParserSymbols.STRING_LITERAL, yytext().substring(1, yytext().length()-1));
}
