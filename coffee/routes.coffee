window.app or= {}

MainRouter = Backbone.Router.extend
	routes:
		'':                           'root'
		'config':                     'config'
		'reset':                      'reset'
		'practice/':                  'math'
		'practice/:operation':        'math'
		'practice/:operation/:group': 'math'

	root: ->
		console.log 'root route'

	math: (operation='addition', group='0') ->
		(new ProblemView()).initilize operation, group

	reset: ->
		console.log 'resetting'

	config: ->
		console.log 'configuring'

app.router = new MainRouter()
