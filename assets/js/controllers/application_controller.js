import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
	el:"#app",
  data: {
		loader: true,
  },
	created: function() {
    console.log("Vue connected!!");
    let application = document.getElementById("application").value
		this.channel = socket.channel("application:join", {application: application});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully", resp);
        console.log(resp)
        this.loader = false;
			})
			.receive("error", resp => {
				console.log("Unable to join", resp);
			});
	}
});
