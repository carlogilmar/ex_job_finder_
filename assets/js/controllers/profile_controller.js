import Vue from 'vue'
import socket from "./../socket"
import Notifications from 'vue-notification'
import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.snow.css'
Vue.use(Notifications)

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
    tracks: [],
    track: ""
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
        console.log(resp)
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
      this.channel.push("profile:add_skill", {skill:description, profile: profile_id})
        .receive('ok', (res) => {
					this.skills = res.skills;
					this.skill = "";
					this.notify('success', 'Skill añadido', '');
				})
				.receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
		},
		delete_skill: function(skill_id){
      this.channel.push("profile:delete_skill", {skill:skill_id, profile: this.profile.id})
        .receive('ok', (res) => {
					this.skills = res.skills;
					this.notify('warn', 'Skill eliminado', '');
				})
				.receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
    },
    add_track: function(track, profile_id){
      this.channel.push("profile:add_track", {track:track, profile: profile_id})
        .receive('ok', (res) => {
					this.tracks = res.tracks;
					this.track = "";
					this.notify('success', 'Track añadido', '');
				})
				.receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
		},
		delete_track: function(track_id){
      this.channel.push("profile:delete_track", {track: track_id, profile: this.profile.id})
        .receive('ok', (res) => {
					this.tracks = res.tracks;
					this.notify('warn', 'Track eliminado', '');
				})
				.receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
    },
	}
});
