window.app or= {}

ProblemView = Backbone.View.extend
	el: '#problemContainer'

	initilize: ->
		do @displayNextQuestion

	events:
		'submit form': 'grade'

	displayNextQuestion: ->
		@render app.session.getLastQuestionSet().getNewQuestion()

	render: (data={}) ->
		newProblem = $("#problem-template-#{_.random 0, 2}").html()

		$('#problemContainer').html _.template newProblem, data

		@

	grade: (event) ->
		do event.preventDefault

		lastQuestionSet = app.session.getLastQuestionSet()

		correct = lastQuestionSet.answerQuestion @$el.find('input[name = answer]').val()

		# FIXME display 'correct', and add a button to switch to the next question here

		if app.session.finishedWithOperation()
			app.session.nextRound()
		else if lastQuestionSet.finishedWithSet()
			app.router.navigate "practice/#{lastQuestionSet.get 'operation'}/#{1 + Number(lastQuestionSet.get('group'))}", trigger: true

		do @displayNextQuestion

window.app.ProblemView = ProblemView
