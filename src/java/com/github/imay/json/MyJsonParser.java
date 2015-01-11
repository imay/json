package com.github.imay.json;

import com.google.gson.JsonElement;

import java.io.Reader;
import java.io.StringReader;

public class MyJsonParser {

    public static JsonElement parse(Reader jsonStr) throws Exception {
        JsonParser parser = new JsonParser(new JsonScanner(jsonStr));
        return (JsonElement) parser.parse().value;
    }
    public static JsonElement parse(String jsonStr) throws Exception {
        return parse(new StringReader(jsonStr));
    }
}
