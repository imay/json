
terminal COLON, COMMA, LBRACE, RBRACE, LBRACKET, RBRACKET, TRUE, FALSE, NULL;
terminal STRING_LITERAL, NUMBER_LITERAL;

// JsonElement
nonterminal JsonElement object, array, value, opt_value_list, value_list;
nonterminal Map.Entry<String, JsonElement> kv_pair;
nonterminal List<Map.Entry<String, JsonElement>> kv_list, opt_kv_list;

object ::= 
    LBRACE opt_kv_list:list RBRACE
    {:
        RESULT = new JsonObject();
        if (list != null) {
            for (Map.Entry<String, JsonElement> entry : list)
                RESULT.add(entry.getKey(), entry.getValue());
            }
        }
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
    | kv_list:list COMMA kv_pair
    {:
        list.add(kv_pair);
        RESULT = list;
    :}
    ;

array ::=
    LBRACKET opt_value_list:array RBRACKET
    {:
        RESULT = array;
    :}
    ;

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
        RESULT = new JsonPrimitive(flase);
    :}
    | NULL
    {:
        RESULT = new JsonNull();
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
        RESULT = new JsonArray(v);
    :}
    | value_list:list COMMA value:v
    {:
        list.add(v);
        RESULT = list;
    :}
    ;

