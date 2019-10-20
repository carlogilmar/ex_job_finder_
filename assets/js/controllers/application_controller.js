import Vue from 'vue'
import socket from "./../socket"
import VCalendar from 'v-calendar';
import Notifications from 'vue-notification'
Vue.use(Notifications)
Vue.use(VCalendar)

export const app = new Vue({
	el:"#app",
  data: {
    attributes: [
      {
        key: 'today',
        dates: new Date(),
          highlight: {
            backgroundColor: '#000000',
          },
          contentStyle: {
            color: '#00000',
          },
          popover: {
            label: 'You just hovered over today\'s date!',
          }
      }
    ],
		loader: true,
		application: []
  },
	created: function() {
    console.log("Vue connected!!");
    let application = document.getElementById("application").value
		this.channel = socket.channel("application:join", {application: application});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully", resp);
        console.log(resp)
				this.application = resp.application;
        this.loader = false;
			})
			.receive("error", resp => {
				console.log("Unable to join", resp);
			});
	}
});
