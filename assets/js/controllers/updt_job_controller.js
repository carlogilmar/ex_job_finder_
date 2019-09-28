import Vue from 'vue'
import socket from "./../socket"
import Notifications from 'vue-notification'
import VueTagsInput from '@johmun/vue-tags-input';
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
    extra_tags: "",
    tag: '',
    tags: [],
    placeholderValue: 'Max 5 tags',
    job: {
      position: null,
      company_name: null,
      modality: null,
      hiring_scheme: null,
      location_restricted: null,
      salary: null,
      primary_tag: "",
      extra_tags: null,
      description: "",
      responsabilities: "",
      requirements: "",
      apply_description: "",
      contact_info: ""
    }
  },
	components: {
		LocalQuillEditor: VueQuillEditor.quillEditor,
		VueTagsInput
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
    update_tags: function(){
      let tags= this.get_tags(this.tags);
      this.update_job(tags, "extra_tags", this.job.id);
      this.job.extra_tags = tags;
    },
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
    update: function(value, attribute){
      this.update_job(value, attribute, this.job.id);
    },
    update_job: function(value, attribute,  job_id){
      this.channel.push("updt_job:update", {job: job_id, attribute: attribute, value: value})
        .receive('ok', (res) => {
          this.notify('info', 'Vacante Actualizada', attribute+' updated [ok]');
        })
        .receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
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
    }
  }
});
