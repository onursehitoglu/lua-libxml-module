require("lua-libxml2")

local doc = xml2.loadFile("test.xml")
local xpc = xml2.newXPathContext(doc)
local xml2Obj = xml2.xmlXPathEvalExpression(xpc, "/log/books")
local node = xml2.findNodes(xml2Obj)

while (node) do
    local children = xml2.childNode(node)
    while (children) do
        nodename = xml2.nodeName(children)
        local name  = xml2.getAttribute(children, "name")
        local value = xml2.getAttribute(children, "value")
        if name and value then
            print(nodename .. "  name = " .. name .. ", value = " .. value)
        end
        children = xml2.nextNode(children)
    end
    node = xml2.nextNode(node)
end

xml2.freeXPathObject(xml2Obj)
xml2.freeXPathContext(xpc)
xml2.freeDoc(doc)
xml2.xmlCleanupParser()
