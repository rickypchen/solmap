var initCAMap = function() {
	$('.cost').click(function (event) {
		event.preventDefault();
		features.selectAll("path").attr("class", function(d) {
			var $that = $(this);
	  	var name = d.properties.name.replace(", CA", "");
	  	$.ajax({
	  		url: '/colors',
	  		data: {name: name},
	  	})
	  	.done(function (countyData) {
	  		var cost = countyData.avg_annual_cost;
	  		console.log(cost);
	  		if (cost >= 3000 ) {
	  			$that.attr("class", "q5-6");
	  		} else if ( cost >= 2500 && cost < 3000 ) {
	  			$that.attr("class", "q4-6");
	  		} else if ( cost >= 2200 && cost < 2500 ) {
	  			$that.attr("class", "q3-6");
	  		} else if ( cost >= 1500 && cost < 2200 ) {
	  			$that.attr("class", "q1-6");
	  		} else if ( cost < 1500 ) {
	  			$that.attr("class", "q0-6");
	  		}
	  	})
	  	.fail(function () {
	  		console.log("Booo! You suck!")
	  	});

	  });
	});

	$('.dni').click(function (event) {
		event.preventDefault();
		features.selectAll("path").attr("class", function(d) {
			var $that = $(this);
	  	var name = d.properties.name.replace(", CA", "");
	  	$.ajax({
	  		url: '/colors',
	  		data: {name: name},
	  	})
	  	.done(function (countyData) {
	  		var dni = countyData.irradiance_dni;
    		if (dni >= 7) {
    			$that.attr("class", "q5-6");
    		} else if ( dni >= 6.5 && dni < 7 ) {
    			$that.attr("class", "q4-6");
    		} else if ( dni >= 6 && dni < 6.5 ) {
    			$that.attr("class", "q3-6");
    		} else if ( dni >= 5.5 && dni < 6 ) {
    			$that.attr("class", "q2-6");
    		} else if ( dni >= 5 && dni < 5.5 ) {
    			$that.attr("class", "q1-6");
    		} else if ( dni < 5 ) {
    			$that.attr("class", "q0-6");
    		}
	  	})
	  	.fail(function () {
	  		console.log("Booo! You suck!")
	  	});

	  });
	});








	var width = 520,
	    height = 600;

	//Map projection
	var projection = d3.geo.conicEqualArea()
	    .scale(3417.0640963445344)
	    .center([-119.52652507689999,37.1529012619412]) //projection center
	    .parallels([32.528832,42.009339]) //parallels for conic projection
	    .rotate([119.52652507689999]) //rotation for conic projection
	    .translate([-4041.0537196636506,-2807.5905948475697]) //translate to center the map in view

	//Generate paths based on projection
	var path = d3.geo.path()
	    .projection(projection);

	//Create an SVG
	var svg = d3.select("#state").append("svg")
	    .attr("width", width)
	    .attr("height", height);

	//Group for the map features
	var features = svg.append("g")
	    .attr("class","features");

	//Create choropleth scale
	var color = d3.scale.quantize()
	    .domain([0,1])
	    .range(d3.range(6).map(function(i) { return "q" + i + "-6"; }));

	//Create a tooltip, hidden at the start
	var tooltip = d3.select("#state").append("div").attr("class","tooltip");

	//Keeps track of currently zoomed feature
	var centered;

	d3.json("/assets/ca.geojson",function(error,geodata) {
	  if (error) return console.log(error); //unknown error, check the console

	  //Create a path for each map feature in the data
	  features.selectAll("path")
	  	.data(geodata.features)
	    .enter()
	    .append("path")
	    .attr("d",path)
	    .attr("class", function(d) {
	    	var $that = $(this);
	    	var name = d.properties.name.replace(", CA", "");
	    	$.ajax({
	    		url: '/colors',
	    		data: {name: name},
	    	})
	    	.done(function (countyData) {
	    		var dni = countyData.irradiance_dni;
	    		if (dni >= 7) {
	    			$that.attr("class", "q5-6");
	    		} else if ( dni >= 6.5 && dni < 7 ) {
	    			$that.attr("class", "q4-6");
	    		} else if ( dni >= 6 && dni < 6.5 ) {
	    			$that.attr("class", "q3-6");
	    		} else if ( dni >= 5.5 && dni < 6 ) {
	    			$that.attr("class", "q2-6");
	    		} else if ( dni >= 5 && dni < 5.5 ) {
	    			$that.attr("class", "q1-6");
	    		} else if ( dni < 5 ) {
	    			$that.attr("class", "q0-6");
	    		}
	    	})
	    	.fail(function () {
	    		console.log("Booo! You suck!")
	    	});

	    })
	    .on("mouseover",showTooltip)
	    .on("mousemove",moveTooltip)
	    .on("mouseout",hideTooltip)
	    .on("click",clicked);

	});

	// Zoom to feature on click
	function clicked(d,i) {

	  //Add any other onClick events here

	  var x, y, k;

	  if (d && centered !== d) {
	    // Compute the new map center and scale to zoom to
	    var centroid = path.centroid(d);
	    var b = path.bounds(d);
	    x = centroid[0];
	    y = centroid[1];
	    k = .8 / Math.max((b[1][0] - b[0][0]) / width, (b[1][1] - b[0][1]) / height);
	    centered = d
	  } else {
	    x = width / 2;
	    y = height / 2;
	    k = 1;
	    centered = null;
	  }

	  // Highlight the new feature
	  features.selectAll("path")
	      .classed("highlighted",function(d) {
	          return d === centered;
	      })
	      .style("stroke-width", 1 / k + "px"); // Keep the border width constant

	  //Zoom and re-center the map
	  //Uncomment .transition() and .duration() to make zoom gradual
	  features
	      //.transition()
	      //.duration(500)
	      .attr("transform","translate(" + width / 2 + "," + height / 2 + ")scale(" + k + ")translate(" + -x + "," + -y + ")");
	}


	//Position of the tooltip relative to the cursor
	var tooltipOffset = {x: 5, y: -25};

	//Create a tooltip, hidden at the start
	function showTooltip(d) {
		var name = d.properties.name.replace(", CA", "");

		$.ajax({
			url: '/county_data',
			data: {name: name},
		})
		.done(function (countyData) {
			tooltip.style("display","block").html(countyData);
		})
		.fail(function () {
			console.log("Booo! You suck!")
		});

	  moveTooltip();

	  
	}

	//Move the tooltip to track the mouse
	function moveTooltip() {
	  tooltip.style("top",(d3.event.pageY+tooltipOffset.y)+"px")
	      .style("left",(d3.event.pageX+tooltipOffset.x)+"px");
	}

	//Create a tooltip, hidden at the start
	function hideTooltip() {
	  tooltip.style("display","none");
	}
};