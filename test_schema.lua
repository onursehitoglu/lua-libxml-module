require("lua-libxml2")

if (not arg[1] or not arg[2]) then
	print("usage: " .. arg[0] .. " xmlfile xsdfile")
	os.exit(-1)
end

local doc = xml2.loadFile(arg[1])
local schema = xml2.SchemaParser(arg[2])

if (doc and schema)  then
	local r = xml2.SchemaValidateDoc(schema,doc)
	if (r == 0) then
		print("validation succeeds" )
	else
		print("validation fails:" .. r)
	end
else
	print("cannot load documents")
end
xml2.freeDoc(doc)
xml2.SchemaFree(schema)
xml2.xmlCleanupParser()
