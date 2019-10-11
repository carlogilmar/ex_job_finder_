import Vue from 'vue'
import socket from "./../socket"
import Notifications from 'vue-notification'
Vue.use(Notifications)

export const app = new Vue({
	el:"#app",
  data: {
  },
	created: function() {
    let profile = document.getElementById("profile").value
		this.channel = socket.channel("profile:join", {profile: profile});
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
  /*
   * Notifications
   * */
    notify: function(type, title, context){
      this.$notify({
        group: 'foo',
        type: type,
        title: title,
        text: context,
        duration: 1000,
        speed: 1000
      })
    },
    //update_job: function(value, attribute,  job_id){
    //  this.channel.push("updt_job:update", {job: job_id, attribute: attribute, value: value})
    //    .receive('ok', (res) => {
    //      if(attribute !== 'description' && attribute !== 'apply_description'
    //        && attribute !== 'requirements' && attribute !== 'responsabilities'){
    //        this.notify('info', 'Guardando el cambio...', '');
    //      }
    //    })
    //    .receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
    //},
  }
});
