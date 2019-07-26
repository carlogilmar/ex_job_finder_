import Vue from 'vue'
import socket from "./../socket"
import VueQuillEditor from 'vue-quill-editor'
import VueTagsInput from '@johmun/vue-tags-input';
import 'quill/dist/quill.snow.css'
import Notifications from 'vue-notification'
import ImageUploader from 'vue-image-upload-resize'
Vue.use(Notifications)
Vue.use(ImageUploader)

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
    job_empty: null,
		position: null,
		company_name: null,
		location_restricted: "Ciudad de México",
		primary_tag: "",
		extra_tags: "",
		salary: null,
		description: "Agrega tu descripción",
		responsabilities: "Responsabilidades de la vacante",
		requirements: "Requerimientos indispensables",
		apply_description: "¿Alguna otra observación o comentario?",
		url: null,
		email: null,
		tag: '',
		tags: [],
		primary_tags: [],
		placeholderValue: 'Puedes agregar hasta 5 categorias',
		placeholderValueMainTag: 'Agrega solo 1 categoria',
		image: null,
		hasImage: null
	},
	created: function() {
		this.channel = socket.channel("remote:job", {});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully", resp);
			})
			.receive("error", resp => {
				console.log("Unable to join", resp);
			});
	},
	mounted() { $("#fileInput").hide(); },
	components: {
		VueTagsInput,
		LocalQuillEditor: VueQuillEditor.quillEditor
	},
	computed: {
		editorB() {
			return this.$refs.quillEditorB.quill
		}
	},
	methods:{
    setImage: function(output) {
      this.hasImage = true;
      this.image = output;
    },
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
		get_tags: function(tags){
			if(tags.length === 0){
				return null;
			} else {
				let current_tags = [];
				tags.forEach(function(element) {
					current_tags.push(element.text);
				});
				return current_tags;
			}
		},
    confirm_preview:function(){
      let job = this.get_job();
			let job_values = Object.values(job);
			if(job_values.includes(null) || job_values.includes("")){
        this.job_empty = "Por favor completa todos los campos de la vacante";
				this.notify('warn', 'Vacante Incompleta', 'Completa tu vacante para continuar');
			} else {
        this.job_empty = null;
        $("#myModalConfirmation").modal('show');
			}
    },
		create_job: function(){
      $("#myModalConfirmation").modal('hide');
      let job = this.get_job()
			let job_values = Object.values(job);
			if(job_values.includes(null) || job_values.includes("")){
				this.notify('error', 'Vacante Incompleta', 'Completa tu vacante para continuar');
			} else {
				this.channel.push("remote:create", {data: job})
					.receive('ok', (res) => {
						this.notify('success', 'Vacante en proceso de ser publicada', 'Verifica tu correo para confirmar publicación');
            $("#reloadModal").modal({backdrop: 'static', keyboard: false});
					});
			}
		},
    reload_page: function(){
      location.reload();
    },
    get_job: function(){
			let job = {
				position: this.position,
				company_name: this.company_name,
				location_restricted: this.location_restricted,
				primary_tag: this.get_tags(this.primary_tags),
				extra_tags: this.get_tags(this.tags),
				salary: this.salary,
				description: this.description,
				responsabilities: this.responsabilities,
				requirements: this.requirements,
				apply_description: this.apply_description,
				url: this.url,
				email: this.email,
        logo: this.image
			}
			return job;
    }
	}
});
