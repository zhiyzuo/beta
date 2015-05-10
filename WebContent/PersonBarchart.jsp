<%@page import="org.w3c.dom.css.RGBColor"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@page import="org.json.simple.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>



<!DOCTYPE html>
<html>

<body>
	
	<div class="container">
	 <div id="main" style="width:100%;height:500px"></div>
	</div>

	 <sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    	    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
        	user="zhiyzuo" password="gljfeef"/>
        	
   	 <sql:query var="year_count" dataSource="${jdbc}">
			select count(*) as count, pub_year from medline.journal 
			where medline.journal.pmid in 
			(select medline.author.pmid from medline.author 
			where last_name='Amblard'
 			and fore_name='P') and pub_year is not null
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

	 
	 
	<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
	
 	<script>

 	
	require.config({
		  paths: {
		    echarts: 'http://echarts.baidu.com/build/dist'
		  }
		});

		// 
		require(
		  [
		    'echarts',
		    'echarts/chart/bar', // bar chart
		  ],
		  function (ec) {
		    //
		    var myChart = ec.init(document.getElementById('main'));
		    
		    //数据准备
		    var dataset = JSON.parse(document.getElementById("jsondiv").innerHTML.trim());
		 	var count = [];
		 	var year = [];
		 	for (i = 0; i < dataset.length; i++) { 
		 	    count.push(Number(dataset[i].count));
		 	    year.push(String(dataset[i].year));
		 	}

		    var option = {
		      //
		      title:{
		        text:'Barchart'
		      },
		      //
		      tooltip: {
		    	 show: true,
		      },
		      legend: {
		        data:['pub_by_year'],
		      },
		      //
		      xAxis : [
		        {
		          type : 'category',
		          data: year,
		          name: 'year'
		        }
		      ],
		      yAxis : [
		        {
		          type : 'value',
		          name : 'count'
		        }
		      ],
		      //
		      series : [
		        {
		          "name":"pub_by_year",
		          "type":"bar",
		          "data":count,
		          markPoint : {
		                data : [
		                    {type : 'max', name: 'Max'},
		                    {type : 'min', name: 'Min'}
		                ]
		            },
		            markLine : {
		                data : [
		                    {type : 'average', name: 'Avg'}
		                ]
		            }
		        }
		      ]
		    };

		    //console.log(option.xAxis);
		    // 
		    myChart.setOption(option); 
		  }
		);
	</script>

</body>
</html>