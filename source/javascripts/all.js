//= require_tree .
function lazyLoadVideos() {
    'use strict';
    var videos = document.getElementsByClassName("embed-video");

    for (var i = 0; i < videos.length; i++) {
        // Set the thumbnail image
        videos[i].style.backgroundImage = "url(" + videos[i].getAttribute("data-thumbnail") + ")";

        // Overlay the Play icon to make it look like a video player
        var play = document.createElement("div");
        play.setAttribute("class", "play");
        videos[i].appendChild(play);

        videos[i].onclick = function(e) {
            // Allow opening the video in a new tab by Ctrl- (Windows) or Cmd- (OS X) clicking the video.
            if (e.ctrlKey || e.metaKey) {
                return true;
            }
            e.preventDefault(); // Otherwise, don't open the link

            // Create an iframe for the embedded player
            var iframe = document.createElement("iframe");
            iframe.setAttribute("src", this.getAttribute("data-url"));
            iframe.setAttribute("frameborder", "0");

            // Replace the thumbnail with the player
            this.parentNode.replaceChild(iframe, this);
        };
    }
}
document.addEventListener("DOMContentLoaded", lazyLoadVideos);
