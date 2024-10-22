// assets/js/game.js

import { Socket } from "phoenix";

// Set up WebSocket connection to Phoenix Channels
let socket = new Socket("/socket", { params: { token: window.userToken } });

// Connect to the WebSocket
socket.connect();

// Join the game channel once (e.g., "game:1234")
let channel = socket.channel("game:1234", { player_id: "player123" });

channel
    .join()
    .receive("ok", (resp) => {
        console.log("Joined successfully", resp);
    })
    .receive("error", (resp) => {
        console.log("Unable to join", resp);
    });

// Listen for updates from the server (e.g., game state updates)
channel.on("game_state", (payload) => {
    console.log("New game state received:", payload);
});

// Function to send a move to the server
export function sendMove(move) {
    console.log("Sending move:", move);
    channel
        .push("player_move", { move: move })
        .receive("ok", (resp) => {
            console.log("Move sent successfully", resp);
        })
        .receive("error", (resp) => {
            console.log("Error sending move", resp);
        });
}

window.sendMove = sendMove;
