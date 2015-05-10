
	<div class="container">
	 <div id="person_barchart" style="width:100%;height:500px"></div>
	</div>

	 <sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    	    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
        	user="zhiyzuo" password="gljfeef"/>
        	
   	 <sql:query var="researcher_year_count" dataSource="${jdbc}">
			select count(*) as count, EXTRACT(year FROM date_created) as pub_year from medline.article 
			where medline.article.pmid in 
			(select pmid from medline.author where fore_name = 
			(select first_name from beta.user_info where id = CAST(? AS INTEGER)) and last_name =
			(select last_name from beta.user_info where id = CAST(? AS INTEGER))) and date_created is not null
 			group by pub_year order by pub_year;
 			<sql:param value="${param.username}"/>
			<sql:param value="${param.username}"/>
	 </sql:query>
	 
	 <div id="person_count_jsondiv" style="display:none">
		 <json:array name="year_count_json">
		  <c:forEach items="${researcher_year_count.rows}" var="row">
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
		    var myChart = ec.init(document.getElementById('person_barchart'));
		    
		    var dataset = JSON.parse(document.getElementById("person_count_jsondiv").innerHTML.trim());
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
		      
		      toolbox: {
		          show : true,
		          feature : {
		              mark : {show: true,
			            	  title : {
			                      mark : 'Mark On',
			                      markUndo : 'Mark Undo',
			                      markClear : 'Mark Clear',
			                  },  
		              	},
		              dataView : {show: true,
		            	  title : 'Data View',
		                  readOnly: false,
		                  lang: ['Data View', 'Close', 'Refresh']
		              	},
		              restore : {show: true, title : 'Restore'},
		              saveAsImage : {show: true,
			            	  title : 'Save as',
			                  type : 'png',
			                  lang : ['Click to save']}
		          		},
		      },
		      xAxis : [
		        {
		          type : 'category',
		          data: year,
		          name: 'year',
		          axisLabel : {
		                show:true,
		                interval: 'auto',
		                rotate: 45,
		                textStyle: {
		                    fontFamily: 'sans-serif',
		                    fontSize: 15,
		                    fontStyle: 'italic',
		                    fontWeight: 'bold'
		                }
		            },
		        }
		      ],
		      yAxis : [
		        {
		          type : 'value',
		          name : 'count',
		          axisLabel : {
		                show:true,
		                interval: 'auto',
		                rotate: -20,
		                textStyle: {
		                    fontFamily: 'sans-serif',
		                    fontSize: 15,
		                    fontStyle: 'italic',
		                    fontWeight: 'bold'
		                }
		            },
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