import Vue from 'vue'
import socket from "./../socket"
import Notifications from 'vue-notification'
Vue.use(Notifications)

export const app = new Vue({
	el:"#app",
  data: {
    job: {
      position: null,
      company_name: null,
      modality: null
    }
  },
	created: function() {
    let job = document.getElementById("job").value
		this.channel = socket.channel("updt_job:join", {job: job});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully", resp);
        this.job = resp;
        console.log(this.job);
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
    upt_position: function(value, attribute){
      this.update_job(value, attribute, this.job.id);
    },
    update_job: function(value, attribute,  job_id){
      this.channel.push("updt_job:update", {job: job_id, attribute: attribute, value: value})
        .receive('ok', (res) => {
          this.notify('info', 'Vacante Actualizada', '');
        })
        .receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
    }
  }
});
