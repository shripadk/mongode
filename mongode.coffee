Db 			  =	require('mongodb').Db
Connection	  =	require('mongodb').Connection
Server		  = require('mongodb').Server
EventEmitter  = require('events').EventEmitter
sys			  = require('sys')
colors		  = require('colors')

class Mongode extends EventEmitter
	constructor: (database, host, port, serverConfig, options) ->
		@database   	= database
		@host 			= host or '127.0.0.1'
		@port 			= port or 27017
		@serverConfig   = serverConfig || {}
		@options 		= options || {}
		@connected      = false
		
		db = new Db(@database, new Server(@host, @port, @serverConfig), @options)
		db.open (e, db) =>
			if e
				@emit 'error', e
				@emit 'log', "#{new Date()} : Error: #{e}"
				throw new Error(e)
			if db
				@db = db
				@connected = true
				@emit 'log', "#{new Date()} : Connected: #{db.databaseName}"
				@emit 'connection', db
	
	state : () ->
		return @connected
	
	logInfo : (info) ->
		@emit 'log', "#{new Date()} : #{info}".blue
		
	logError : (error) ->
		@emit 'log', "#{new Date()} : Error: #{error.toString().replace(/error:/i, '')}".red
	
	handleCallback : () ->
		@logError "Not supplied a callback!"
		return true

	handleCollection : () ->
		@logError "No collection specified!"
		return true
		
	insertInto : (col, data, callback) ->
		if @connected
			if !callback
				@handleCallback()
				return true
			if !col
				return true
				@handleCollection()
			if !data
				@logError "No data specified for insertion! Command: insertInto"
				return true
			if data and col
				@db.collection col, (e, collection) =>
					if e
						@emit 'error', e
						@logError e
						callback e, null
					if collection
						collection.insert data, (e, docs) =>
							if e
								@emit 'error', e
								@logError e
								callback e, null
							if docs
								@logInfo "Inserted doc(s)! Command: insertInto"
								callback null, docs
	
	findAll : (col, callback) ->
		if @connected
			if !callback
				@handleCallback()
				return true
			if !col
				return true
				@handleCollection()
			if col and callback
				@db.collection col, (e, collection) =>
					if e
						@emit 'error', e
						@logError e
						callback e, null
					if collection
						collection.find (e, cursor) =>
							if e
								@emit 'error', e
								@logError e
								callback e, null
							if cursor
								cursor.toArray (e, docs) =>
									if e
										@emit 'error', e
										@logError e
										callback e, null
									if docs
										@logInfo "Fetched all doc(s)! Command: findAll"
										callback null, docs
	
	findFirst : (col, callback) ->
		if @connected
			if !callback
				@handleCallback()
				return true
			if !col
				return true
				@handleCollection()
			if col and callback
				@db.collection col, (e, collection) =>
					if e
						@emit 'error', e
						@logError e
						callback e, null
					if collection
						collection.findOne {}, {}, (e, doc) =>
							if e
								@emit 'error', e
								@logError e
								callback e, null
							if doc
								@logInfo "Fetched doc! Command: findFirst"
								callback null, doc
	findOne : (col, query, options, callback) ->
		if @connected
			if !query or typeof query is 'function'
				@logError "Query should be of type object! Command: fineOne"
				return true
			if !options or typeof options is 'function'
				@logError "Option should be of type object! Command: fineOne"
				return true
			if !callback
				@handleCallback()
				return true
			if !col
				return true
				@handleCollection()
			if col and callback
				@db.collection col, (e, collection) =>
					if e
						@emit 'error', e
						@logError e
						callback e, null
					if collection
						collection.findOne query, options, (e, doc) =>
							if e
								@emit 'error', e
								@logError e
								callback e, null
							if doc
								@logInfo "Fetched doc! Command: findOne"
								callback null, doc
exports.Mongode = Mongode