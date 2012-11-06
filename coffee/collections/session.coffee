window.app or= {}

Session = Backbone.Collection.extend
	localStorage: new Backbone.LocalStorage 'Session'

	operations: [
		'addition'
		'subtraction'
	]

	setsPerOperation: 10

	getLastQuestionSet: ->
		@models[-1..][0]

	finishedWithOperation: ->
		@models.length is @setsPerOperation

	nextRound: ->
		lastQuestionSet = do @getLastQuestionSet
		group           = lastQuestionSet.get 'group'
		operation       = lastQuestionSet.get 'operation'

		if @setsPerOperation is group
			if operation is @allOperations[-1..][0] # on the last operation?
				#FIXME: add a bonus round w/all operations!
				app.router.navigate 'finished', trigger: true
			else
				nextOperation = @allOperations[1 + @allOperations.indexOf operation]
				app.router.navigate "practice/#{nextOperation}/0", trigger: true

app.Session = Session
