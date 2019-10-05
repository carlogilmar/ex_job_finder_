import Vue from 'vue'
import socket from "./../socket"
import VueApexCharts from 'vue-apexcharts'
Vue.component('apexchart', VueApexCharts)

export const app = new Vue({
	el:"#app",
  data: {
		loader: true,
		series: [],
		chartOptions: {
			dataLabels: {
				enabled: false
			},
			colors: ["#008FFB"],
			title: {
				text: ''
			}
		},
    counter: 0,
    info: []
  },
	created: function() {
		this.channel = socket.channel("analytics:join", {});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully");
        this.series = resp.analytics;
        this.counter = resp.counter;
        this.info = resp.info;
				this.loader = false;
			})
			.receive("error", resp => {
				console.log("Unable to join", resp);
			});
	},
  methods: {
  }
});
