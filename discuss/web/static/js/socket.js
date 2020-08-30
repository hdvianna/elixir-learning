import {Socket} from "phoenix"

const userData = document.getElementById("userData");

if (userData) {
    window.userToken = userData.value;
}

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()


function createChannel(topicId, join) {
  let channel = socket.channel(`comments:${topicId}`, {})
  channel.join()
    .receive("ok", join)
    .receive("error", resp => { console.log("Unable to join", resp) });
  return channel
}

export { createChannel };

