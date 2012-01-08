(function(){
/**
* Utility function for adding an event. Handles the inconsistencies
* between the W3C method for adding events (addEventListener) and
* IE's (attachEvent).
*/
    function addEvent(element, eventName, callback) {
        if (element.addEventListener) {
            element.addEventListener(eventName, callback, false);
        }
        else {
            element.attachEvent('on' + eventName, callback);
        }
    }


    var ready = function(player_id) {
        console.log("ready!")
        // Keep a reference to Froogaloop for this player
        var froogaloop = $f(player_id);

        function setupSimpleButtons() {
            var buttons = document.querySelector('#buttons')
            var go = buttons.querySelector('.go');

            // Call play when play button clicked
            addEvent(go, 'click', function() {
                console.log("supdawg")
                froogaloop.api('play');
            }, false);
        }

        /**
         * Adds listeners for the events that are checked. Adding an event
         * through Froogaloop requires the event name and the callback method
         * that is called once the event fires.
         */
        function setupEventListeners() {
            function onLoadProgress() {
                froogaloop.addEvent('loadProgress', function(data) {
                    //console.log('loadProgress event : ' + data.percent + ' : ' + data.bytesLoaded + ' : ' + data.bytesTotal + ' : ' + data.duration);
                });
            }

            function onPlayProgress() {
                froogaloop.addEvent('playProgress', function(data) {
                    //console.log('playProgress event : ' + data.seconds + ' : ' + data.percent + ' : ' + data.duration);
                    enja.timeline.trigger("play:progress", data);
                });
            }

            function onPlay() {
                froogaloop.addEvent('play', function(data) {
                    console.log('play event');
                });
            }

            function onPause() {
                froogaloop.addEvent('pause', function(data) {
                    console.log('pause event');
                });
            }

            function onFinish() {
                froogaloop.addEvent('finish', function(data) {
                    console.log('finish');
                });
            }

            function onSeek() {
                froogaloop.addEvent('seek', function(data) {
                    console.log('seek event : ' + data.seconds + ' : ' + data.percent + ' : ' + data.duration);
                    enja.timeline.trigger("seek", data);
                });
            }

            // Calls the change event if the option is checked
            // (this makes sure the checked events get attached on page load as well as on changed)
            onLoadProgress();
            onPlayProgress();
            onPlay();
            onPause();
            onFinish();
            onSeek();
        }

        setupSimpleButtons();
        setupEventListeners();
    }


    // Listen for the ready event for any vimeo video players on the page
    var vimeoPlayers = document.querySelectorAll('.vimeo'),
        player;
    //console.log("sup", vimeoPlayers);


    //document.addEventListener("DOMContentLoaded", function () {
    setTimeout(function(){ 
        for (var i = 0, length = vimeoPlayers.length; i < length; i++) {
            player = vimeoPlayers[i];
            console.log("player", player)

            $f(player).addEvent('ready', ready);
        }
    }, 500);

})();
