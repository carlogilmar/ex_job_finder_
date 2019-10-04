import Vue from 'vue'
import socket from "./../socket"
import VueApexCharts from 'vue-apexcharts'
Vue.component('apexchart', VueApexCharts)

function generateData(count, yrange) {
  console.log("Generating data");
      var i = 0;
      var series = [];
      while (i < count) {
        var x = 'w' + (i + 1).toString();
        var y = Math.floor(Math.random() * (yrange.max - yrange.min + 1)) + yrange.min;

        series.push({
          x: x,
          y: y
        });
        i++;
      }
      return series;
    }

export const app = new Vue({
	el:"#app",
  data: {
		series: [{
			name: 'Metric1',
			data: [
        {x: "Domingo", y:90},
        {x: "Lunes", y:90},
        {x: "Martes", y:90},
        {x: "Miércoles", y:90},
        {x: "Jueves", y:90},
        {x: "Viernes", y: 150},
        {x: "Sábado", y: 100}
      ]

		},
			{
				name: 'Metric2',
				data: generateData(18, {
					min: 0,
					max: 90
				})
			},
			{
				name: 'Metric3',
				data: generateData(18, {
					min: 0,
					max: 90
				})
			},
			{
				name: 'Metric4',
				data: generateData(18, {
					min: 0,
					max: 90
				})
			},
			{
				name: 'Metric5',
				data: generateData(18, {
					min: 0,
					max: 90
				})
			},
			{
				name: 'Metric6',
				data: generateData(18, {
					min: 0,
					max: 90
				})
			},
			{
				name: 'Metric7',
				data: generateData(18, {
					min: 0,
					max: 90
				})
			},
			{
				name: 'Metric8',
				data: generateData(18, {
					min: 0,
					max: 90
				})
			},
			{
				name: 'Metric9',
				data: generateData(18, {
					min: 0,
					max: 90
				})
			}
		],
		chartOptions: {
			dataLabels: {
				enabled: false
			},
			colors: ["#008FFB"],
			title: {
				text: ''
			}
		}
  },
	created: function() {
		this.channel = socket.channel("analytics:join", {});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully", resp);
        this.series = resp;
			})
			.receive("error", resp => {
				console.log("Unable to join", resp);
			});
    console.log(this.series);
	},
  methods: {
  }
});
