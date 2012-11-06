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

		{correct, correctAnswer} = lastQuestionSet.answerQuestion @$el.find('input[name=answer]').val()

		nextQuestionForm = null
		if correct
			nextQuestionForm = $ _.template $('#correct').html(), {}
		else
			nextQuestionForm = $ _.template $('#incorrect').html(), correctAnswer: correctAnswer

		$('#problemContainer').html nextQuestionForm
		$('.nextQuestion').on 'click', => do @displayNextQuestion

		if app.session.finishedWithOperation()
			do @undelegateEvents # disable this view before navigating to a new one
			app.session.nextRound()
		else if lastQuestionSet.finishedWithSet()
			do @undelegateEvents # disable this view before navigating to a new one
			app.router.navigate "practice/#{lastQuestionSet.get 'operation'}/#{1 + Number(lastQuestionSet.get('group'))}", trigger: true


window.app.ProblemView = ProblemView
