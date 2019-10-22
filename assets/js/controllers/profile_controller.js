import Vue from 'vue'
import socket from "./../socket"
import Notifications from 'vue-notification'
import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.snow.css'
import VCalendar from 'v-calendar';
Vue.use(Notifications)
Vue.use(VCalendar)

export const app = new Vue({
	el:"#app",
  data: {
    editorOption: {
      theme: 'snow',
      modules: {
        toolbar: [
          [{ 'size': ['small', false, 'large'] }],
          ['bold', 'italic'],
          [{ 'list': 'ordered'}, { 'list': 'bullet' }],
        ]
      }
    },
    loader: true,
    profile: {
      id: 0,
      name: "cargando...",
      email: "cargando...",
      phone: "cargando...",
      inserted_at: "cargando..."
    },
		skills: [],
    skill: "",
    applications: [],
    job_for_apply: "Vacante",
    jobs: [{company_name: "job", position: "job"}]
  },
	components: {
		LocalQuillEditor: VueQuillEditor.quillEditor
	},
	computed: {
		editorB() {
			return this.$refs.quillEditorB.quill
		}
	},
	created: function() {
    let profile = document.getElementById("profile").value
		this.channel = socket.channel("profile:join", {profile: profile});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully", resp);
        this.profile = resp.profile;
				this.skills = resp.skills;
        this.tracks = resp.tracks;
				this.jobs = resp.jobs;
        this.applications = resp.applications;
        this.loader = false;
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
    update: function(value, attribute, id){
      this.channel.push("profile:update", {profile: id, attribute: attribute, value: value})
        .receive('ok', (res) => {
          this.notify('info', 'Guardando el cambio...', '');
        })
        .receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
    },
    add_skill: function(description, profile_id){
      if(this.skill !== ""){
      this.channel.push("profile:add_skill", {skill:description, profile: profile_id})
        .receive('ok', (res) => {
					this.skills = res.skills;
					this.skill = "";
					this.notify('success', 'Skill añadido', '');
				})
				.receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
      }
		},
		delete_skill: function(skill_id){
      this.channel.push("profile:delete_skill", {skill:skill_id, profile: this.profile.id})
        .receive('ok', (res) => {
					this.skills = res.skills;
					this.notify('warn', 'Skill eliminado', '');
				})
				.receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
    },
    add_application: function(){
      this.channel.push("profile:create_application", {job: this.job_for_apply, profile: this.profile.id})
        .receive('ok', (res) => {
					this.applications = res.applications;
					this.notify('success', 'Aplicación en proceso...', '');
				})
				.receive("error", resp => { this.notify('error', 'Erro al crear', ''); });
    }
	}
});
