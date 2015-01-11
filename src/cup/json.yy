// Parser for Json

package com.github.imay.json;

import java_cup.runtime.Symbol;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonNull;


import java.util.List;
import java.util.Map;

terminal COLON, COMMA, LBRACE, RBRACE, LBRACKET, RBRACKET, TRUE, FALSE, NULL;
terminal String STRING_LITERAL, NUMBER_LITERAL;

// JsonElement
nonterminal JsonElement object, array, value;
nonterminal JsonArray opt_value_list, value_list;
nonterminal Map.Entry<String, JsonElement> kv_pair;
nonterminal List<Map.Entry<String, JsonElement>> kv_list, opt_kv_list;

start with value;

value ::=
    STRING_LITERAL:str
    {:
        RESULT = new JsonPrimitive(str);
    :}
    | NUMBER_LITERAL:number
    {:
        RESULT = new JsonPrimitive(number);
    :}
    | TRUE
    {:
        RESULT = new JsonPrimitive(true);
    :}
    | FALSE
    {:
        RESULT = new JsonPrimitive(false);
    :}
    | NULL
    {:
        RESULT = JsonNull.INSTANCE;
    :}
    | object:obj
    {:
        RESULT = obj;
    :}
    | array:array
    {:
        RESULT = array;
    :}
    ;

object ::= 
    LBRACE opt_kv_list:list RBRACE
    {:
        JsonObject obj = new JsonObject();
        if (list != null) {
            for (Map.Entry<String, JsonElement> entry : list) {
                obj.add(entry.getKey(), entry.getValue());
            }
        }
        RESULT = obj;
    :}
    ;

kv_pair ::= 
    STRING_LITERAL:key COLON value:value
    {:
        RESULT = Maps.immutableEntry(key, value);
    :}
    ;

opt_kv_list ::=
    /* Empty */
    {:
        RESULT = null;
    :}
    | kv_list:list
    {:
        RESULT = list;
    :}
    ;

kv_list ::=
    kv_pair:item
    {:
        RESULT = Lists.newArrayList(item);
    :}
    | kv_list:list COMMA kv_pair:item
    {:
        list.add(item);
        RESULT = list;
    :}
    ;

array ::=
    LBRACKET opt_value_list:array RBRACKET
    {:
        RESULT = array;
    :}
    ;


opt_value_list ::=
    /* Empty */
    {:
        RESULT = new JsonArray();
    :}
    | value_list:list
    {:
        RESULT = list;
    :}
    ;

value_list ::=
    value:v
    {:
        JsonArray array = new JsonArray();
        array.add(v);
        RESULT = array;
    :}
    | value_list:list COMMA value:v
    {:
        list.add(v);
        RESULT = list;
    :}
    ;

