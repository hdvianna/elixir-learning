// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"


// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import { createChannel } from "./socket"

document.addEventListener("DOMContentLoaded", () => {
    const topicData = document.getElementById("topicData");
    const addComment = document.getElementById("addComment");
    const commentField = document.getElementById("commentField");

    if (topicData && addComment && commentField) {
        setUpCommentPost(topicData, addComment, commentField);
    }

});

function setUpCommentPost(topicData, addComment, commentField) {
    const topicID = topicData.value;
    const commentListContainer = document.getElementById("commentList");
    
    let channel = createChannel(topicID, (response) => {
        const commentList = response.comments.map(createCommentHTML).join("");
        commentListContainer.innerHTML = commentList;
    });

    channel.on(`comments:${topicID}:new`, (event) => {
        let commentHTML = createCommentHTML(event.comment);
        commentListContainer.innerHTML += commentHTML;
    });

    addComment.addEventListener('click', () => {
        let content = commentField.value;
        commentField.value = "";
        channel.push('comment:add', {
            content: content
        });
    });

    function createCommentHTML(comment) {
        let email = comment.user ? comment.user.email : "anonymous";
        return `<li class="collection-item">
            ${comment.content}  
            <div class="secondary-content">${email}</div>
        </li>`;
    }

}

