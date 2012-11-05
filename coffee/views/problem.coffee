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
		templateNumber = Math.floor(Math.random()*3)
		newProblem     = $("#problem-template-#{templateNumber}").html()

		$('#problemContainer').html _.template newProblem, data

		@

	grade: (event) ->
		do event.preventDefault

		correct = app.session.getLastQuestionSet().answerQuestion @$el.find('input[name = answer]').val()

		if correct
			alert 'right!' # display 'correct', and add a button to switch to the next question here

		do @displayNextQuestion

window.app.ProblemView = ProblemView
