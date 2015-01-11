package com.github.imay.json;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.junit.Assert;
import org.junit.Test;

public class MyJsonParserTest {
    @Test
    public void testNormal() throws Exception {
        JsonElement element = MyJsonParser.parse("{\"a\":\"123\"}");
        JsonObject object = element.getAsJsonObject();
        Assert.assertNotNull(object);
        Assert.assertEquals("123", object.getAsJsonPrimitive("a").getAsString());
        Assert.assertEquals(123, object.getAsJsonPrimitive("a").getAsInt());

        element = MyJsonParser.parse("{\"a\":\"123e2\"}");
        object = element.getAsJsonObject();
        Assert.assertNotNull(object);
        Assert.assertEquals("123e2", object.getAsJsonPrimitive("a").getAsString());
        Assert.assertEquals(12300, object.getAsJsonPrimitive("a").getAsBigDecimal().intValue());
    }

}