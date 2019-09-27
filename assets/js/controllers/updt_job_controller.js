import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
	el:"#app",
  data: {
  },
	created: function() {
    let job = document.getElementById("job").value
		this.channel = socket.channel("updt_job:join", {job: job});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully", resp);
			})
			.receive("error", resp => {
				console.log("Unable to join", resp);
			});
	},
  methods: {
  }
});
