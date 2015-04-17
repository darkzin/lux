// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require device
//= require jquery
//= require jquery_ujs
//= require sketch_commander
//= require_tree .
//
$(function(){
  canvasHeight = $(window).height() - $("#title").height() - $("#menu").height() - 5;
  $("canvas#sketchbook").attr("height", canvasHeight);
  //alert($(window).width());
  $("canvas#sketchbook").attr("width", $(window).width()-20);
  //$("canvas#sketchbook").css({"width": "100%"});
  //$("canvas#sketchbook").css({"margin": "0 auto"});
  //alert($("canvas#sketchbook").attr("width"));
//$("canvas#sketchbook").height(canvasHeight).width("100%");
  sketch = $("canvas#sketchbook").sketchCommander();
    console.log(typeof(Media));
});
