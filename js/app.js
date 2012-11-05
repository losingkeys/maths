(function(){var e,t,n,r,i,s;n=function(){function e(e,t){this.group=e!=null?e:0,this.alreadyUsed=t!=null?t:[]}return e}(),window.app||(window.app={}),t=Backbone.Router.extend({routes:{"":"root",config:"config",reset:"reset",finished:"finished",practice:"math","practice/:operation":"math","practice/:operation/:group":"math"},root:function(){return console.log("root route")},math:function(e,t){return e==null&&(e="addition"),t==null&&(t="0"),app.session||(app.session=new app.Session),app.session.push(new app.QuestionSet({operation:e,group:t})),(new app.ProblemView).initilize()},reset:function(){return console.log("resetting")},config:function(){return console.log("configuring")},finished:function(){return alert("finished")}}),app.router=new t,window.app||(window.app={}),$(function(){return console.log(Backbone.history.start()),(new app.GlobalView).initilize()}),window.app||(window.app={}),s=Backbone.Collection.extend({operations:["addition","subtraction"],setsPerOperation:10,getLastQuestionSet:function(){return this.models.slice(-1)[0]},nextRound:function(){var e,t,n,r;return t=this.getLastQuestionSet(),e=t.get("group"),r=t.get("operation"),this.setsPerOperation()===e?r===this.allOperations.slice(-1)[0]?app.router.navigate("finished"):(n=this.allOperations[1+this.allOperations.indexOf(r)],app.router.navigate("practice/"+n+"/0")):app.router.navigate("practice/"+r+"/"+ ++e)}}),app.Session=s,window.app||(window.app={}),e=Backbone.View.extend({el:"body",initilize:function(){return console.log("init global view")},events:{"click #config":"renderConfig","click #reset":"nav","click nav":"nav"},renderConfig:function(){return console.log("rendering config page")},nav:function(){return console.log("navigating")}}),window.app.GlobalView=e,window.app||(window.app={}),r=Backbone.View.extend({el:"#problemContainer",initilize:function(){return this.displayNextQuestion()},events:{"submit form":"grade"},displayNextQuestion:function(){return this.render(app.session.getLastQuestionSet().getNewQuestion())},render:function(e){var t,n;return e==null&&(e={}),n=Math.floor(Math.random()*3),t=$("#problem-template-"+n).html(),$("#problemContainer").html(_.template(t,e)),this},grade:function(e){var t;return e.preventDefault(),t=app.session.getLastQuestionSet().answerQuestion(this.$el.find("input[name = answer]").val()),this.displayNextQuestion()}}),window.app.ProblemView=r,window.app||(window.app={}),i=Backbone.Model.extend({defaults:{operation:"addition",group:"0"},currentOperand:null,questionsPerSet:10,asked:{},getNewQuestion:function(){var e;while(e=_.random(0,this.questionsPerSet))if(!_.contains(_.keys(this.asked),""+e))break;return this.currentOperand=e,this.operation==="subtraction"?{operand0:Math.max(this.get("group"),e),operand1:Math.min(this.get("group"),e),operator:"-"}:_.random(0,1)%2?{operand0:this.get("group"),operand1:e,operator:"+"}:{operand0:e,operand1:this.get("group"),operator:"+"}},checkIfFinished:function(){return this.asked.length===this.questionsPerSet},answerQuestion:function(e){var t,n;return n=0,this.operation==="addition"&&(n=Number(this.currentOperand)+Number(this.get("group"))),this.operation==="subtraction"&&(n=Math.abs(Number(this.currentOperand)-Number(this.get("group")))),t=n===Number(e),this.asked[""+this.currentOperand]={correct:t,submittedAnswer:e},t}}),app.QuestionSet=i}).call(this);