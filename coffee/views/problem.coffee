window.app or= {}

ProblemView = Backbone.View.extend
	className: 'problem'

	initilize: (operation='addition', group='0') ->
		otherOperand = Math.floor Math.random()*10

		# the result cannot be negative, order matters (put the larger number first)
		if operation is 'subtraction'
			@render
				operand0: Math.max(group, otherOperand)
				operand1: Math.min(group, otherOperand)
				operator: '-'
		else # order doesn't matter, this is addition
			if (Math.floor(Math.random()*10))%2
				@render
					operand0: group
					operand1: otherOperand
					operator: '+'
			else
				@render
					operand0: otherOperand
					operand1: group
					operator: '+'

	events:
		'submit form': 'grade'

	render: (data={}) ->
		templateNumber = Math.floor(Math.random()*3)

		$('.problem').replaceWith _.template $("#problem-template-#{templateNumber}").html(), data

		@

	grade: ->
		# pass

window.app.ProblemView = ProblemView
