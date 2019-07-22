import Vue from 'vue'
import socket from "./../socket"
import VueQuillEditor from 'vue-quill-editor'
import VueTagsInput from '@johmun/vue-tags-input';
import 'quill/dist/quill.snow.css'

export const app = new Vue({
	el:"#app",
	data: {
		editorOption: {
      theme: 'snow'
    },
		position: null,
		company_name: null,
		location_restricted: null,
		primary_tag: "",
		extra_tags: "",
		salary: null,
		description: null,
		responsabilities: null,
		requirements: null,
		apply_description: null,
		url: null,
		email: null,
		tag: '',
		tags: [],
		primary_tags: [],
		placeholderValue: 'Agrega tus tags, máximo 5',
		placeholderValueMainTag: 'Categoria principal, solo 1'
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
		create_job: function(){
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
				email: this.email
			}

			let job_values = Object.values(job)
			if(job_values.includes(null) || job_values.includes("")){
				alert("Completa los campos");
			} else {
				this.channel.push("remote:create", {data: job})
					.receive('ok', (res) => {
						alert("Se agrego al dashboard!");
						location.reload();
					});
			}
		}
	}
});
