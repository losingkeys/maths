window.app or= {}

Session = Backbone.Collection.extend
	# localStorage: new Backbone.LocalStorage 'Session'

	operations: [
		'addition'
		'subtraction'
	]

	setsPerOperation: 10

	getLastQuestionSet: ->
		@models[-1..][0]

	nextRound: ->
		lastQuestionSet = do @getLastQuestionSet
		group           = lastQuestionSet.get 'group'
		operation       = lastQuestionSet.get 'operation'

		if do @setsPerOperation is group
			if operation is @allOperations[-1..][0] # on the last operation?
				#FIXME: add a bonus round w/all operations!
				app.router.navigate 'finished'
			else
				nextOperation = @allOperations[1 + @allOperations.indexOf operation]
				app.router.navigate "practice/#{nextOperation}/0"
		else
			app.router.navigate "practice/#{operation}/#{++group}"

app.Session = Session
