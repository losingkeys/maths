window.app or= {}

Session = Backbone.Collection.extend
	localStorage: new Backbone.LocalStorage 'Session'

	allOperations: [
		'addition'
		'subtraction'
	]

	setsPerOperation: 11

	getLastQuestionSet: ->
		@models[-1..][0]

	finishedWithOperation: ->
		Number(@setsPerOperation) is Number(@getLastQuestionSet().get 'group')

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
