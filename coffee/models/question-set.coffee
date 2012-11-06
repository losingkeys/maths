window.app or= {}

QuestionSet = Backbone.Model.extend
	defaults:
		operation: 'addition'
		group:     '0'
		currentOperand: null
		asked: {}

	questionsPerSet: 11

	initialize: ->
		@set 'asked', {}

	getNewQuestion: ->
		# get an operand we haven't used yet this round
		while true
			operand = _.random 0, @questionsPerSet-1
			unless _.contains _.keys(@get('asked')), "#{operand}"
				break

		@set 'currentOperand', operand

		# the result cannot be negative, order matters (put the larger number first)
		if @operation is 'subtraction'
			operand0: Math.max @get('group'), operand
			operand1: Math.min @get('group'), operand
			operator: '-'
		else # order doesn't matter, this is addition
			if _.random(0, 1)%2
				operand0: @get('group')
				operand1: operand
				operator: '+'
			else
				operand0: operand
				operand1: @get('group')
				operator: '+'

	finishedWithSet: ->
		_.keys(@get('asked')).length is @questionsPerSet

	answerQuestion: (submittedAnswer) ->
		correctAnswer = null

		if @operation is 'addition'
			correctAnswer = Number(@get('currentOperand')) + Number(@get('group'))

		if @operation is 'subtraction'
			correctAnswer = Math.abs Number(@get('currentOperand')) - Number(@get('group'))

		correct = correctAnswer is Number(submittedAnswer)

		@get('asked')["#{@get('currentOperand')}"] =
			correct:         correct
			submittedAnswer: submittedAnswer

		correct

app.QuestionSet = QuestionSet
