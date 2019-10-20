import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
	el:"#app",
  data: {
		loader: true,
  },
	created: function() {
    console.log("Vue connected!!");
	}
});
