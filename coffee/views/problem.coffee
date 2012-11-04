window.app or= {}

ProblemView = Backbone.View.extend
	el: '#problemContainer'

	recentProblem: {}

	initilize: (operation='addition', group='0') ->
		otherOperand = Math.floor Math.random()*10

		# the result cannot be negative, order matters (put the larger number first)
		if operation is 'subtraction'
			@recentProblem =
				operand0: Math.max group, otherOperand
				operand1: Math.min group, otherOperand
				operator: '-'
		else # order doesn't matter, this is addition
			if (Math.floor(Math.random()*10))%2
				@recentProblem =
					operand0: group
					operand1: otherOperand
					operator: '+'
			else
				@recentProblem =
					operand0: otherOperand
					operand1: group
					operator: '+'

		@render @recentProblem

	events:
		'submit form': 'grade'

	render: (data={}) ->
		templateNumber = Math.floor(Math.random()*3)
		newProblem     = $("#problem-template-#{templateNumber}").html()

		$('#problemContainer').html _.template newProblem, data

		@

	grade: (event) ->
		do event.preventDefault

		correctAnswer   = 0
		submittedAnswer = @$el.find('input[name = answer]').val()

		if @recentProblem.operator is '+'
			correctAnswer = Number(@recentProblem.operand0) + Number(@recentProblem.operand1)

		if @recentProblem.operator is '-'
			correctAnswer = Number(@recentProblem.operand0) - Number(@recentProblem.operand1)

		if correctAnswer is Number(submittedAnswer)
			alert 'right!'

window.app.ProblemView = ProblemView
