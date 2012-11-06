(function(){var e,t,n,r,i;window.app||(window.app={}),t=Backbone.Router.extend({routes:{"":"root",config:"config",reset:"reset",finished:"finished",practice:"math","practice/:operation":"math","practice/:operation/:group":"math"},root:function(){return console.log("root route")},math:function(e,t){return e==null&&(e="addition"),t==null&&(t="0"),app.session||(app.session=new app.Session),app.session.push(new app.QuestionSet({operation:e,group:t})),(new app.ProblemView).initilize()},reset:function(){return console.log("resetting")},config:function(){return console.log("configuring")},finished:function(){return alert("finished")}}),app.router=new t,window.app||(window.app={}),$(function(){return console.log(Backbone.history.start()),(new app.GlobalView).initilize()}),window.app||(window.app={}),i=Backbone.Collection.extend({localStorage:new Backbone.LocalStorage("Session"),allOperations:["addition","subtraction"],setsPerOperation:10,getLastQuestionSet:function(){return this.models.slice(-1)[0]},finishedWithOperation:function(){var e;return e=this.getLastQuestionSet(),Number(this.setsPerOperation)===Number(e.get("group"))?e.finishedWithSet():!1},nextRound:function(){var e,t,n;return e=this.getLastQuestionSet(),n=e.get("operation"),n===this.allOperations.slice(-1)[0]?app.router.navigate("finished",{trigger:!0}):(t=this.allOperations[1+this.allOperations.indexOf(n)],app.router.navigate("practice/"+t+"/0",{trigger:!0}))}}),app.Session=i,window.app||(window.app={}),e=Backbone.View.extend({el:"body",initilize:function(){return console.log("init global view")},events:{"click #config":"renderConfig","click #reset":"nav","click nav":"nav"},renderConfig:function(){return console.log("rendering config page")},nav:function(){return console.log("navigating")}}),window.app.GlobalView=e,window.app||(window.app={}),n=Backbone.View.extend({el:"#problemContainer",initilize:function(){return this.displayNextQuestion()},events:{"submit form":"grade"},displayNextQuestion:function(){return this.render(app.session.getLastQuestionSet().getNewQuestion())},render:function(e){var t;return e==null&&(e={}),t=$("#problem-template-"+_.random(0,2)).html(),$("#problemContainer").html(_.template(t,e)),this},grade:function(e){var t,n;return e.preventDefault(),n=app.session.getLastQuestionSet(),t=n.answerQuestion(this.$el.find("input[name=answer]").val()),app.session.finishedWithOperation()?(this.undelegateEvents(),app.session.nextRound()):n.finishedWithSet()&&(this.undelegateEvents(),app.router.navigate("practice/"+n.get("operation")+"/"+(1+Number(n.get("group"))),{trigger:!0})),this.displayNextQuestion()}}),window.app.ProblemView=n,window.app||(window.app={}),r=Backbone.Model.extend({defaults:{operation:"addition",group:"0",currentOperand:null,asked:{}},questionsPerSet:11,initialize:function(){return this.set("asked",{})},getNewQuestion:function(){var e;for(;;){e=_.random(0,this.questionsPerSet-1);if(!_.contains(_.keys(this.get("asked")),""+e))break}return this.set("currentOperand",e),this.get("operation")==="subtraction"?{operand0:Math.max(this.get("group"),e),operand1:Math.min(this.get("group"),e),operator:"-"}:_.random(0,1)%2?{operand0:this.get("group"),operand1:e,operator:"+"}:{operand0:e,operand1:this.get("group"),operator:"+"}},finishedWithSet:function(){return _.keys(this.get("asked")).length===this.questionsPerSet},answerQuestion:function(e){var t,n;return n=null,this.operation==="addition"&&(n=Number(this.get("currentOperand"))+Number(this.get("group"))),this.operation==="subtraction"&&(n=Math.abs(Number(this.get("currentOperand"))-Number(this.get("group")))),t=n===Number(e),this.get("asked")[""+this.get("currentOperand")]={correct:t,submittedAnswer:e},t}}),app.QuestionSet=r}).call(this);