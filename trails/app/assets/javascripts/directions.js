var origin = {}
var destination = {}

MQA.EventUtil.observe(window, 'load', function() {
	// create an object for options
	var options = {
  elt: document.getElementById('map'),           // ID of map element on page
  zoom: 10,                                      // initial zoom level of the map

  // Make a Ajax call to local sever (current_user.lan & current_user.lon)
  latLng: { lat: 39.743943, lng: -105.020089 },  // center of map in latitude/longitude
    mtype: 'map',                                  // map type (map, sat, hyb); defaults to map
    bestFitMargin: 0,                              // margin offset from map viewport when applying a bestfit on shapes
    zoomOnDoubleClick: true                        // enable map to be zoomed in when double-clicking on map
	};
 
  // construct an instance of MQA.TileMap with the options object
  window.map = new MQA.TileMap(options);

  // download the modules
  MQA.withModule('largezoom', 'viewoptions', 'geolocationcontrol', 'insetmapcontrol', 'mousewheel', function() {
 
    // add the Large Zoom control
    map.addControl(
      new MQA.LargeZoom(),
      new MQA.MapCornerPlacement(MQA.MapCorner.TOP_LEFT, new MQA.Size(5,5))
    );
 
    // add the Map/Satellite toggle button
    map.addControl(new MQA.ViewOptions());
 
    // add the Geolocation button
    map.addControl(
      new MQA.GeolocationControl(),
      new MQA.MapCornerPlacement(MQA.MapCorner.TOP_RIGHT, new MQA.Size(10,50))
    );
 
    // add the small Inset Map with custom options
    map.addControl(
      new MQA.InsetMapControl({
        size: { width: 150, height: 125 },
        zoom: 3,
        mapType: 'map',
        minimized: true
      }),
      new MQA.MapCornerPlacement(MQA.MapCorner.BOTTOM_RIGHT)
    );
 
    // enable zooming with your mouse
    map.enableMouseWheelZoom();
  });
  // download the module
  MQA.withModule('new-route', function() {
 
    // uses the MQA.TileMap.addRoute function to pass in an array
    // of locations as part of the request parameter
    map.addRoute({
      request: {
        locations: [
          { latLng: {lat: 39.637433, lng: -105.163867 }},
          { latLng: {lat: 39.743943, lng: -105.020089 }}
        ]
      }
    });
  });
});