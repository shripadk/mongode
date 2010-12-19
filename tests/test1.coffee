Mongode 	= require('./../mongode.coffee').Mongode
testdb		= new Mongode('test', 'localhost', 27017, {}, {native_parser: true})
sys			= require('sys')
testdb.on 'connection', () ->
	# testdb.insertInto 'foo.bar.baz', [{foo: "bar"}, {bar: "baz"}, {bar: "baz"}], (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	# testdb.update 'foo.bar.baz', {bar: "baz"}, {$unset: {super: []} }, {multi:true}, (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	# testdb.insertInto 'foo.bar.baz', {bar: "baz"}, (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	# testdb.insertInto 'foo.bar.baz', {baz: "buzz"}, (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	# testdb.removeFrom 'foo.bar.baz', {bar: "baz"}, (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	# testdb.dropCollection 'foo.bar.baz', (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	
	# 
	# testdb.insertInto 'supertest', [{a: 3}, {b: 4}, {c: 5}, {d: 6}], (e, c) ->
	# 	if e then console.log e
	# 	if c then console.log c
	testdb.find 'foo.bar.baz', {}, {age: 1, _id: 0}, {sort: [['age', -1]]}, (e, c) ->
		if e then console.log e
		if c then console.log c
	# 
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

testdb.on 'error', (err) ->
	console.log err
	
testdb.on 'log', (message) ->
	console.log message
