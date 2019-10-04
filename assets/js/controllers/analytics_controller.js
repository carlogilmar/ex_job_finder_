import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
	el:"#app",
  data: {
  },
	created: function() {
		this.channel = socket.channel("analytics:join", {});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully", resp);
        this.job = resp;
			})
			.receive("error", resp => {
				console.log("Unable to join", resp);
			});
	},
  methods: {
  }
});
