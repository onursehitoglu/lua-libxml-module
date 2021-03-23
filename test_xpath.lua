require("lua-libxml2")

function traverse(node,indent)
	io.write(indent ..  xml2.nodeName(node))
	local attrs = xml2.getAllAttribute(node)
	if (attrs) then 
		io.write(" [")
		for k,v in pairs(attrs) do
			io.write(k .. "=" .. v .. ", ")
		end
		io.write("]")
	end
	print()

	local child = xml2.childNode(node)
	while (child) do
		traverse(child, indent .. "   ")
		child = xml2.nextNode(child)
	end
end

if (not arg[1] or not arg[2]) then
	print("usage: " .. arg[0] .. " xmlfile xpathexpr")
	os.exit(-1)
end

local doc = xml2.loadFile(arg[1])

if (not doc) then
	os.exit(1)
end




local xpc = xml2.newXPathContext(doc)

if (#arg < 3) then
	print("usage: ", arg[0], " xmlfile [nsprefix namespace]")
end

if (arg[3] and arg[4]) then
	xml2.registerNs(xpc, arg[3], arg[4])
end

local xpo = xml2.xmlXPathEvalExpression(xpc, arg[2])

if (not xpo) then
	os.exit(-1)
end

local node = xml2.findNodes(xpo)
local count = 1

if (not node) then
	print("path not found")
else
	while (node) do
    	traverse(node, count .. "> ")
    	node = xml2.nextNode(node)
		count = count + 1
	end
end

xml2.freeXPathObject(xpo)
xml2.freeXPathContext(xpc)
xml2.freeDoc(doc)
xml2.xmlCleanupParser()
