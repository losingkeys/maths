window.app or= {}

MainRouter = Backbone.Router.extend
	routes:
		'':                           'root'
		'config':                     'config'
		'reset':                      'reset'
		'finished':                   'finished'
		'practice':                   'math'
		'practice/:operation':        'math'
		'practice/:operation/:group': 'math'

	root: ->
		# pass

	math: (operation='addition', group='0') ->
		app.session or= new app.Session()
		app.session.push new app.QuestionSet operation: operation, group: group
		do (new app.ProblemView()).initilize

	reset: ->
		# pass

	config: ->
		# pass

	finished: ->
		alert 'finished'

app.router = new MainRouter()
