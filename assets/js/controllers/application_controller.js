import Vue from 'vue'
import socket from "./../socket"
import VCalendar from 'v-calendar';
import Notifications from 'vue-notification'
Vue.use(Notifications)
Vue.use(VCalendar)

export const app = new Vue({
  el:"#app",
  data: {
    attributes: [],
    loader: true,
    track: "",
    tracks: [],
    application: []
  },
  created: function() {
    console.log("Vue connected!!");
    let application = document.getElementById("application").value
    this.channel = socket.channel("application:join", {application: application});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully", resp);
        this.application = resp.application;
        this.tracks = resp.tracks;
        this.loader = false;
        this.generate_calendar();
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods:{
    generate_calendar: function(){
      let dates = [];
      for(let index=0; index < (this.tracks.length); index++){
        let date = this.tracks[index];
        let date_for_show = {
          highlight: {backgroundColor: '#000000'},
          contentStyle: {color: '#00000'},
          popover: { label: date.description },
          dates: [new Date(date.year, date.month, date.day)],
        }
        dates.push(date_for_show)

      }
      this.attributes = dates;
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
    add_track: function(){
      if(this.track !== ""){
        this.channel.push("application:add_track", {track: this.track, application: this.application.id})
          .receive('ok', (res) => {
            this.tracks = res.tracks;
            console.log(res);
            this.track = "";
            this.generate_calendar();
            this.notify('success', 'Track añadido', '');
          })
          .receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
      }
    },
    delete_track: function(track_id){
      this.channel.push("application:delete_track", {track: track_id, application: this.application.id})
        .receive('ok', (res) => {
          this.tracks = res.tracks;
          this.generate_calendar();
          this.notify('info', 'Track elimiando', '');
        })
        .receive("error", resp => { this.notify('error', 'No se pudo actualizar', ''); });
    },
  }
});
