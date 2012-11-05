window.app or= {}

Session = Backbone.Collection.extend
	# localStorage: new Backbone.LocalStorage 'Session'

	operations: [
		'addition'
		'subtraction'
	]

	getLastQuestionSet: ->
		@models[-1..][0]

	nextRound: ->
		if do @getLastQuestionSet().checkIfFinished
			if @operation is @allOperations[-1..] # on the last operation?
				#FIXME: add a bonus round w/all operations!
				app.router.navigate 'finished'
			else
				nextOperation = @allOperations[1 + @allOperations.indexOf @operation]
				app.router.navigate "practice/#{nextOperation}/0"
		else
			app.router.navigate "practice/#{@operation}/#{++@group}"

app.Session = Session
