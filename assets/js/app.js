import "phoenix_html";
import LiveSocket from "phoenix_live_view";

import "../css/app.css";

const socket = new LiveSocket("/live");
socket.connect();
