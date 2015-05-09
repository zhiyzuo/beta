<%@page import="org.w3c.dom.css.RGBColor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@page import="org.json.simple.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

	<style>
		#chart rect{
		  fill: steelblue;
		}
		
		#chart text{
		  fill: white;
		  font: 10px sans-serif;
		  text-anchor: end; 
		}
		
		.axis text{
		  font: 10px sans-serif;
		}
		
		.axis path, .axis line{
		  fill: none;
		  stroke : #fff;
		  shape-rendering: crispEdges;
		}
		
		body{
		  background: #1a1a1a;
		  color : #eaeaea;
		  padding : 10px;
		}

	</style>
</head>

<body>

	 <sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    	    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
        	user="zhiyzuo" password="gljfeef"/>
        	
   	 <sql:query var="year_count" dataSource="${jdbc}">
			select count(*) as count, pub_year from medline.journal 
			where medline.journal.pmid in 
			(select medline.author.pmid from medline.author 
			where last_name='<%=session.getAttribute("last_name") %>'
 			and fore_name='<%=session.getAttribute("first_name") %>') 
 			group by pub_year order by pub_year;
	 </sql:query>
	 
	 <div id="jsondiv" style="display:none">
		 <json:array name="year_count_json">
		  <c:forEach items="${year_count.rows}" var="row">
			    <json:object>
			      <json:property name="count" value="${row.count}"/>
			      <json:property name="year" value="${row.pub_year}"/>
			    </json:object>
		    </c:forEach>
		</json:array>
	 </div>
	 <div id="chart"></div>

 	
 	
	<script src="http://d3js.org/d3.v3.min.js"></script>
	<script>
	var w = 600;
	var h = 250;

	//var dataset = [ {"count":1,"year":1865},{"count":1,"year":1866},{"count":3,"year":1868},{"count":3,"year":1869},{"count":2,"year":1870},{"count":3,"year":1871},{"count":5,"year":1873},{"count":4,"year":1874},{"count":1,"year":1875},{"count":3,"year":1879},{"count":4,"year":1880},{"count":3,"year":1881},{"count":2,"year":1882},{"count":1,"year":1886},{"count":4,"year":1887},{"count":1,"year":1888},{"count":2,"year":1889},{"count":1,"year":1890},{"count":2,"year":1895},{"count":1,"year":1896},{"count":2,"year":1898}];
	var dataset = JSON.parse(document.getElementById("jsondiv").innerHTML.trim());
	var xScale = d3.scale.ordinal()
					.domain(d3.range(dataset.length))
					.rangeRoundBands([0, w], 0.05); 

	var yScale = d3.scale.linear()
					.domain([0, d3.max(dataset, function(d) {return d.count;})])
					.range([0, h]);

	var key = function(d) {
		return d.year;
	};

	//Create SVG element
	var svg = d3.select("body")
				.append("svg")
				.attr("width", w)
				.attr("height", h);

	//Create bars
	svg.selectAll("rect")
	   .data(dataset, key)
	   .enter()
	   .append("rect")
	   .attr("x", function(d, i) {
			return xScale(i);
	   })
	   .attr("y", function(d) {
			return h - yScale(d.count);
	   })
	   .attr("width", xScale.rangeBand())
	   .attr("height", function(d) {
			return yScale(d.count);
	   })
	   .attr("fill", function(d) {
			return "rgb(0, 0, " + (d.count * 10) + ")";
	   })

		//Tooltip
		.on("mouseover", function(d) {
			//Get this bar's x/y values, then augment for the tooltip
			var xPosition = parseFloat(d3.select(this).attr("x")) + xScale.rangeBand() / 2;
			var yPosition = parseFloat(d3.select(this).attr("y")) + 14;
			
			//Update Tooltip Position & value
			d3.select("#tooltip")
				.style("left", xPosition + "px")
				.style("top", yPosition + "px")
				.select("#value")
				.text(d.count);
			d3.select("#tooltip").classed("hidden", false)
		})
		.on("mouseout", function() {
			//Remove the tooltip
			d3.select("#tooltip").classed("hidden", true);
		})	;

	//Create labels
	svg.selectAll("text")
	   .data(dataset, key)
	   .enter()
	   .append("text")
	   .text(function(d) {
			return d.count;
	   })
	   .attr("text-anchor", "middle")
	   .attr("x", function(d, i) {
			return xScale(i) + xScale.rangeBand() / 2;
	   })
	   .attr("y", function(d) {
			return h - yScale(d.count) + 14;
	   })
	   .attr("font-family", "sans-serif") 
	   .attr("font-size", "11px")
	   .attr("fill", "white");
	   
	var sortOrder = false;
	var sortBars = function () {
	    sortOrder = !sortOrder;
	    
	    sortItems = function (a, b) {
	        if (sortOrder) {
	            return a.count - b.count;
	        }
	        return b.count - a.count;
	    };

	    svg.selectAll("rect")
	        .sort(sortItems)
	        .transition()
	        .delay(function (d, i) {
	        return i * 50;
	    })
	        .duration(1000)
	        .attr("x", function (d, i) {
	        return xScale(i);
	    });

	    svg.selectAll('text')
	        .sort(sortItems)
	        .transition()
	        .delay(function (d, i) {
	        return i * 50;
	    })
	        .duration(1000)
	        .text(function (d) {
	        return d.count;
	    })
	        .attr("text-anchor", "middle")
	        .attr("x", function (d, i) {
	        return xScale(i) + xScale.rangeBand() / 2;
	    })
	        .attr("y", function (d) {
	        return h - yScale(d.count) + 14;
	    });
	};
	// Add the onclick callback to the button
	d3.select("#sort").on("click", sortBars);
	d3.select("#reset").on("click", reset);
	function randomSort() {

		
		svg.selectAll("rect")
	        .sort(sortItems)
	        .transition()
	        .delay(function (d, i) {
	        return i * 50;
	    })
	        .duration(1000)
	        .attr("x", function (d, i) {
	        return xScale(i);
	    });

	    svg.selectAll('text')
	        .sort(sortItems)
	        .transition()
	        .delay(function (d, i) {
	        return i * 50;
	    })
	        .duration(1000)
	        .text(function (d) {
	        return d.count;
	    })
	        .attr("text-anchor", "middle")
	        .attr("x", function (d, i) {
	        return xScale(i) + xScale.rangeBand() / 2;
	    })
	        .attr("y", function (d) {
	        return h - yScale(d.count) + 14;
	    });
	}
	
	function reset() {
		svg.selectAll("rect")
			.sort(function(a, b){
				return a.year - b.year;
			})
			.transition()
	        .delay(function (d, i) {
	        return i * 50;
			})
	        .duration(1000)
	        .attr("x", function (d, i) {
	        return xScale(i);
			});
			
		svg.selectAll('text')
	        .sort(function(a, b){
				return a.year - b.year;
			})
	        .transition()
	        .delay(function (d, i) {
	        return i * 50;
	    })
	        .duration(1000)
	        .text(function (d) {
	        return d.year;
	    })
	        .attr("text-anchor", "middle")
	        .attr("x", function (d, i) {
	        return xScale(i) + xScale.rangeBand() / 2;
	    })
	        .attr("y", function (d) {
	        return h - yScale(d.year) + 14;
	    });
	};
	</script>
	 

</body>
</html>