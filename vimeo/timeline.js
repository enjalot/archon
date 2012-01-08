var enja;
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
};
enja = {};
enja.timeline = _.extend({}, Backbone.Events);
enja.Tock = (function() {
  __extends(Tock, Backbone.Model);
  function Tock() {
    this.on_play = __bind(this.on_play, this);
    this.on_seek = __bind(this.on_seek, this);
    Tock.__super__.constructor.apply(this, arguments);
  }
  Tock.prototype.defaults = {
    start: 0,
    end: 1
  };
  Tock.prototype.initialize = function() {
    this.last_seconds = 0;
    enja.timeline.bind("play:progress", this.on_play);
    return enja.timeline.bind("seek", this.on_seek);
  };
  Tock.prototype.on_seek = function(data) {
    this.seeked = true;
    this.last_seconds = data.seconds;
    this.get("callback")("seek", data);
    if (data.seconds < this.get("start")) {
      this.start_fired = false;
      if (data.seconds < this.get("end")) {
        return this.stop_fired = false;
      }
    }
  };
  Tock.prototype.on_play = function(data) {
    if (this.fired) {
      this.last_seconds = data.seconds;
      return false;
    }
    if (!this.stop_fired && this.get("end") < data.seconds) {
      this.get("callback")("end", data);
      this.stop_fired = true;
    }
    if (!this.start_fired && this.last_seconds < this.get("start") && this.get("start") < data.seconds) {
      this.get("callback")("start", data);
      this.start_fired = true;
    }
    return this.last_seconds = data.seconds;
  };
  return Tock;
})();
enja.Tocks = (function() {
  __extends(Tocks, Backbone.Collection);
  function Tocks() {
    Tocks.__super__.constructor.apply(this, arguments);
  }
  Tocks.prototype.model = enja.Tock;
  return Tocks;
})();