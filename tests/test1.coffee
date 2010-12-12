Mongode = require('./../mongode.coffee').Mongode
testdb	= new Mongode('test', 'localhost', 27017, {}, {native_parser: true})

testdb.on 'connection', (response) ->
	console.log "Connected to: #{response.databaseName}"

	
	# testdb.insertInto 'supertest', {"_id": "asynchronous", a: "superduper"}, (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	# 
	# testdb.insertInto 'supertest', {"_id": "asynchronous", a: "superduper"}, (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	# 
	# testdb.insertInto 'supertest', [{a: 3}, {b: 4}, {c: 5}, {d: 6}], (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	testdb.find 'supertest', {}, {'a' : 1, '_id' : 0}, (e, c) ->
		if e then console.log e
		if c then console.log c

	
	# testdb.findAll 'supertest', (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	# 
	# testdb.findOne 'supertest', {}, {}, (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	# 
	# testdb.findFirst 'supertest', (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	# 
testdb.on 'error', (err) ->
	console.log err
	
testdb.on 'log', (message) ->
	console.log message