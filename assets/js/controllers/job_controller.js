import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
		position: null,
		company_name: null,
		location_restricted: null,
		primary_tag: null,
		extra_tags: null,
		salary: null,
		description: null,
		responsabilities: null,
		requirements: null,
		apply_description: null,
		url: null,
		email: null
  },
  created: function() {
    console.log("Controller Here!!");
    this.channel = socket.channel("remote:job", {});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully", resp);
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods:{
		create_job: function(){
			alert("Agregando!");
			let job = {
				position: this.position,
				company_name: this.company_name,
				location_restricted: this.location_restricted,
				primary_tag: this.primary_tag,
				extra_tags: this.extra_tags,
				salary: this.salary,
				description: this.description,
				responsabilities: this.responsabilities,
				requirements: this.requirements,
				apply_description: this.apply_description,
				url: this.url,
				email: this.email
			}

      this.channel.push("remote:create", {data: job})
        .receive('ok', () => {
					alert("Procesando");
      });
		}
  }
});
