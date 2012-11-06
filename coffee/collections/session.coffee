window.app or= {}

Session = Backbone.Collection.extend
	localStorage: new Backbone.LocalStorage 'Session'

	allOperations: [
		'addition'
		'subtraction'
	]

	setsPerOperation: 10

	getLastQuestionSet: ->
		@models[-1..][0]

	finishedWithOperation: ->
		lastQuestionSet = @getLastQuestionSet()

		# only return true if we're just finishing w/the last set
		# so you can run through the full final set, but nothing extra
		if Number(@setsPerOperation) is Number(lastQuestionSet.get 'group')
			return lastQuestionSet.finishedWithSet()

		false

	nextRound: ->
		lastQuestionSet = do @getLastQuestionSet
		operation       = lastQuestionSet.get 'operation'

		if operation is @allOperations[-1..][0] # on the last operation?
			#FIXME: add a bonus round w/all operations!
			app.router.navigate 'finished', trigger: true
		else
			nextOperation = @allOperations[1 + @allOperations.indexOf operation]
			app.router.navigate "practice/#{nextOperation}/0", trigger: true

app.Session = Session
