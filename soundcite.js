//loop branch
// window.Popcorn.version = 1.5.6
// http://cdn.popcornjs.org/code/dist/popcorn.min.js

(function (window, document, callback) { // http://stackoverflow.com/questions/2170439/how-to-embed-javascript-widget-that-depends-on-jquery-into-an-unknown-environmen

    let loaded_p = true;    // default is to not load popcornjs

    // document.head not standard before HTML5
    const insertionPoint = document.head || document.getElementsByTagName('head').item(0) || document.documentElement.childNodes[0];

    function cmp_vers(v1, v2) {
        const a1 = v1.split('.');
        const a2 = v2.split('.');
        for (let i = 0; i < Math.min(a1.length, a2.length); i++) {
            const n1 = parseInt(a1[i]);
            const n2 = parseInt(a2[i]);
            const d = n1 - n2;
            if (d) {
                return d;
            }
        }
        return (a1.length - a2.length);
    }

    function load_popcorn(version, cb) {
        let js = window.Popcorn, d, new_js;

        if (loaded_p) {
            cb(js);
        } else if (!js || cmp_vers(version, js.version) > 0 || cb(js)) {
            const script = document.createElement("script");
            script.type = "text/javascript";
            script.src = "https://cdn.knightlab.com/libs/soundcite/latest/vendor/popcorn.min.js"; // no SSL version of this, will self-host
            script.onload = script.onreadystatechange = function () {
                if (!loaded_p && (!(d = this.readyState) || d === "loaded" || d === "complete")) {
                    new_js = window.Popcorn;
                    if (js) {
                        window.Popcorn = js;
                    }
                    cb(new_js, loaded_p = true);
                    insertionPoint.removeChild(script);
                }
            };
            insertionPoint.appendChild(script);
        }
    }

    // http://dustindiaz.com/smallest-domready-ever
    function r(f) {
        if (/in/.test(document.readyState)) {
            setTimeout(function () {
                r(f);
            }, 9);
        } else {
            f();
        }
    }

    r(function () {
        const elements = document.getElementsByClassName('soundcite');

        for (let i = 0; i < elements.length; i++) {
            if (elements[i].getAttribute('data-url')) {
                loaded_p = false;   // needs popcorn
            }
        }

        load_popcorn("1.5.6", function (p) {
            callback(elements, p);
        });
    });

})(window, document, function (soundcite_elements, $Popcorn) {

    const SOUNDCITE_CONFIG = {};
    for (const key in window.SOUNDCITE_CONFIG) {
        SOUNDCITE_CONFIG[key] = window.SOUNDCITE_CONFIG[key];
    }
    const rgb = normalize_background_color(SOUNDCITE_CONFIG.background_color);
    if (rgb) {
        SOUNDCITE_CONFIG.background_color = rgb.join(',');
    } else {
        SOUNDCITE_CONFIG.background_color = '0,0,0';
    }
    const style = document.createElement('style');
    style.type = 'text/css'
    style.innerHTML = '.soundcite-loaded { background-color: rgba(' + SOUNDCITE_CONFIG.background_color + ',.15) }';
    document.getElementsByTagName('head')[0].appendChild(style)

    // borrowing underscore.js bind function
    const bind = function (func, context) {
        const slice = Array.prototype.slice;
        const args = slice.call(arguments, 2);
        return function () {
            return func.apply(context, args.concat(slice.call(arguments)));
        };
    };

    function removeClass(el, name) {
        let cn = el.className;
        for (var i = 0, arr = name.match(/\S+/g); i < arr.length; i++) {
            cn = cn.replace(new RegExp('(?:^|\\s)' + arr[i] + '(?!\\S)'), '');
        }
        el.className = cn;
    }

    function addClass(el, name) {
        let cn = el.className;
        for (var i = 0, arr = name.match(/\S+/g); i < arr.length; i++) {
            if (!cn.match(new RegExp('(?:^|\\s)' + arr[i] + '(?!\\S)'))) {
                cn += " " + arr[i];
            }
        }
        el.className = cn;
    }

    /**
     * Given a string RGB color, break it into a 3-tuple of integers from 0-255. If the string is null
     * or doesn't match a known pattern, return null.
     */
    function normalize_background_color(str) {
        if (!str) return null;
        let rgb = [];
        const RGB_PATTERN = /^(?:rgb|rgba)?\(?(\d+),(\d+),(\d+).*\)?$/;
        let match_group = str.match(RGB_PATTERN);
        if (match_group) {
            rgb = [parseInt(match_group[1]), parseInt(match_group[2]), parseInt(match_group[3])];
        } else {
            const HEX_PATTERN = /^#?([0-9A-F]{1,2})([0-9A-F]{1,2})([0-9A-F]{1,2})$/i;
            match_group = str.match(HEX_PATTERN);
            if (match_group) {
                function hex_to_int(hex) { // make sure to handle single chars correctly
                    if (hex.length === 1) hex = hex + hex;
                    return parseInt(hex, 16);
                }

                rgb = [hex_to_int(match_group[1]), hex_to_int(match_group[2]), hex_to_int(match_group[3])];
            }
        }

        function valid_color(i) {
            return (!isNaN(i) && i >= 0 && i <= 255);
        }

        if (rgb && valid_color(rgb[0]) && valid_color(rgb[1]) && valid_color(rgb[2])) {
            return rgb;
        }
        return null;
    }


    const update_playing_element = function (el, percentage) {
        const color = SOUNDCITE_CONFIG.background_color || '0,0,0';
        el.style.cssText =
            'background: -webkit-linear-gradient(left, rgba(' + color + ',.15)' + percentage + '%, rgba(' + color + ',.05)' + (percentage + 1) + '%);'
            + 'background: linear-gradient(to right, rgba(' + color + ',.15)' + percentage + '%, rgba(' + color + ',.05)' + (percentage + 1) + '%);'
    };

    // global vars
    window.soundcite = {};

    const clips = [];

    // setup audio container
    const audio_container = document.createElement('div');
    addClass(audio_container, 'soundcite-audio');
    document.getElementsByTagName('body')[0].appendChild(audio_container);

    // pause all playing clips. Optionally pass a clip as an argument which
    // should not be paused, for the case that this is triggered from a
    // click handler.
    function pause_all_clips(except_clip) {
        for (let i = 0; i < clips.length; i++) {
            if (clips[i].playing) {
                if (!except_clip || except_clip.el !== clips[i].el) {
                    clips[i].pause();
                }
            }
        }
    }

// Clip
    function Clip(el) {
        this.el = el;
        this.start = el.hasAttribute('data-start') ? el.getAttribute('data-start') : 0; // ms
        this.end = el.hasAttribute('data-end') ? el.getAttribute('data-end') : null;    // ms

        this.plays = el.hasAttribute('data-plays') ? parseInt(el.getAttribute('data-plays')) : 1;
        this.plays_left = this.plays;

        this.playing = false;
        this.sound = null;                          // implement in subclass
        clips.push(this);   // keep track of this
    }

    Clip.prototype.sound_loaded = function () {
        this.el.addEventListener('click', bind(this.click_handler, this));
        addClass(this.el, 'soundcite-loaded soundcite-play');
    };

    Clip.prototype.pause = function () {
        removeClass(this.el, 'soundcite-pause');
        addClass(this.el, 'soundcite-play');
        this.pause_sound();                         // implement in subclass
        this.playing = false;
    }

    Clip.prototype.stop = function () {
        removeClass(this.el, 'soundcite-pause');
        addClass(this.el, 'soundcite-play');
        this.stop_sound();                          // implement in subclass
        this.playing = false;
        this.plays_left = this.plays;    // reset plays_left!
    }

    Clip.prototype.track_progress = function () {
        const totalTime = this.end - this.start;
        const position = this.sound_position();       // implement in subclass
        const relative_position = position - this.start;
        const percentage = (relative_position * 100) / totalTime;
        const update_function = SOUNDCITE_CONFIG.update_playing_element || update_playing_element;
        update_function(this.el, percentage);

    }

    Clip.prototype.click_handler = function (event) {
        event.preventDefault(); // if used on a tag, don't follow href
        pause_all_clips(this);
        if (this.playing) {
            this.pause();
        } else {
            this.play();                            // implement in subclass
        }
    }

// Popcorn Clip
    function PopcornClip(el) {
        Clip.apply(this, Array.prototype.slice.call(arguments));

        this.id = 'soundcite-audio-' + clips.length;
        this.url = el.getAttribute('data-url');

        // convert to ms to secs
        this.start = Math.floor(this.start / 1000);
        if (this.end !== null) {
            this.end = Math.floor(this.end / 1000);
        }

        const audio = document.createElement("audio");
        audio.id = this.id;
        audio.setAttribute("src", this.url);
        audio.setAttribute("preload", "true");

        audio_container.appendChild(audio);

        this.sound = $Popcorn('#' + this.id, {'frameAnimation': true});

        // Safari iOS Audio streams cannot be loaded unless triggered by a
        // user event, so load in play_sound via click for mobile
        this.sound.on('loadeddata', bind(function () {
            if (this.end === null) {
                this.end = this.sound.duration();
            }

            this.sound.cue(this.end, bind(function () {
                if (this.plays) {
                    this.plays_left--;      // update plays_left
                    if (this.plays_left > 0) {
                        this.sound.currentTime(this.start);
                        this.play();
                    } else {
                        this.stop();
                        this.sound.currentTime(this.start);
                    }
                } else {                    // infinite loop
                    this.sound.currentTime(this.start);
                    this.play();
                }
            }, this));

            this.sound_loaded();
        }, this));

        if (this.sound.readyState() > 1) {
            this.sound_loaded();
        }
    }

    PopcornClip.prototype = Object.create(Clip.prototype);

    PopcornClip.prototype.sound_position = function () {
        return this.sound.currentTime();
    }

    PopcornClip.prototype.pause_sound = function () {
        this.sound.pause();
        this.sound.off('timeupdate');
    }

    PopcornClip.prototype.stop_sound = function () {
        this.sound.pause();
        this.sound.off('timeupdate');
    }

    PopcornClip.prototype._play_sound = function () {
        removeClass(this.el, 'soundcite-loading soundcite-play');
        addClass(this.el, 'soundcite-pause');

        this.sound.play();
        this.playing = true;

        this.sound.on('timeupdate', bind(this.track_progress, this));
    }

    PopcornClip.prototype.play_sound = function () {
        var pos = this.sound.roundTime();

        if (pos < this.start || pos >= this.end) {
            this.sound.on('seeked', bind(function () {
                this.sound.off('seeked');
                this._play_sound();
            }, this));

            this.sound.currentTime(this.start);
        } else {
            this._play_sound();
        }
    }

    PopcornClip.prototype.play = function () {
        this.play_sound();
    }

// set up clips array from element array
    for (let i = 0; i < soundcite_elements.length; i++) {
        const el = soundcite_elements[i];
        if (el.getAttribute('data-url')) {
            new PopcornClip(el);
        } else {
            console.log('Unable to form Soundcite element because of missing attributes. The offending Soundcite was "' + el.textContent + '."');
            console.log(el);
        }
    }


    soundcite.Clip = Clip;
    soundcite.PopcornClip = PopcornClip;
    soundcite.clips = clips;    // keep track of clips
    soundcite.pause_all_clips = pause_all_clips;
    soundcite.normalize_background_color = normalize_background_color; // for unit testing
});
