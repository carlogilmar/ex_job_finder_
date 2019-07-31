import Vue from 'vue'
import socket from "./../socket"
import VueQuillEditor from 'vue-quill-editor'
import VueTagsInput from '@johmun/vue-tags-input';
import 'quill/dist/quill.snow.css'
import Notifications from 'vue-notification'
import ImageUploader from 'vue-image-upload-resize'
Vue.use(Notifications)
Vue.use(ImageUploader)
import {data} from './data'
import {methods} from './methods'

export const app = new Vue({
	el:"#app",
  data: data,
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
  // Add in methods.js
  methods: methods
});
