import css from "../css/app.css"
import "phoenix_html"
import socket from "./socket"
import 'bootstrap';
import $ from 'jquery';
window.jQuery = $;
window.$ = $;

/* Live View Socket */
import LiveSocket from "phoenix_live_view"
let liveSocket = new LiveSocket("/live")
liveSocket.connect()
