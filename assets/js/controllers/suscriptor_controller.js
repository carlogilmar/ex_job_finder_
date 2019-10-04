import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
	el:"#app",
  data: {
    email: null,
    name: null,
    error_msg: null,
    done_msg: null
  },
	created: function() {
		this.channel = socket.channel("suscriptor:channel", {});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully", resp);
        this.get_session();
			})
			.receive("error", resp => {
				console.log("Unable to join", resp);
			});
	},
  methods: {
    get_session:function(){
      let that = this;
      $.get("https://api.ipdata.co?api-key=test", function(response) {
        that.channel.push("suscriptor:session", response);
      });
    },
    suscribe: function(){
      this.channel.push("suscriptor:create", {email: this.email, name: this.name})
        .receive('ok', (res) => {
          $("#continueModal").modal('hide');
          this.email = null;
          this.name = null;
          this.done_msg = "This email was suscribed.";
        })
      .receive("error", resp => {
        $("#continueModal").modal('hide');
        this.done_msg = null;
        this.error_msg = "The email was suscribed. Try again";
      });
    },
    validate_form: function(){
      this.done_msg = null;
      if(this.email !== null && this.name !== null){
        $("#continueModal").modal({backdrop: 'static', keyboard: false});
        this.error_msg = null;
      }
    }
  }
});
