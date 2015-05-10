
	<div class="container">
	 <div id="main" style="width:100%;height:500px"></div>
	</div>

	 <sql:setDataSource var="jdbc" driver="org.postgresql.Driver" 
    	    url="jdbc:postgresql://neuromancer.icts.uiowa.edu/institutional_repository"
        	user="zhiyzuo" password="gljfeef"/>
        	
   	 <sql:query var="phase_count" dataSource="${jdbc}">
			select count(*), phase from clinical_trials.clinical_study where id in (select id from clinical_trials.overall_official  where affiliation = 'University of Iowa') group by phase;
	 </sql:query>
	 
	 <div id="jsondiv" style="display:none">
		 <json:array name="phase_count_json">
		  <c:forEach items="${phase_count.rows}" var="row">
		  	<json:object>
			      <json:property name="value" value="${row.count}"/>
			      <json:property name="name" value="${row.phase}"/>
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
 	
 	require(
 			  [
 			    'echarts',
 			    'echarts/chart/pie', 
 			  ],
		  function (ec) {
		    //
		    var myPie = ec.init(document.getElementById('main'));
		    
		    
		    var dataset = JSON.parse(document.getElementById("jsondiv").innerHTML.trim());
		    //console.log(dataset);
		    var name = [];
		 	for (i = 0; i < dataset.length; i++) { 
		 	    name.push(String(dataset[i].name));
		 	}
		 	//console.log(phase);
		    
		    var option = {
		      
		      title : {
		          text: 'Current Summary of Clinical Trials at UIowa',
		          x:'center'
		      },
		      tooltip : {
		          trigger: 'item',
		          formatter: "{a} <br/>{b} : {c} ({d}%)"
		      },
		      calculable : true,
		      legend: {
		          orient : 'vertical',
		          x : 'left',
		          data:name
		      },
		      calculable : true,
		      series : [
		          {
		              name:'phase pie chart',
		              type:'pie',
		              radius : '55%',
		              center: ['50%', '60%'],
                      data:dataset
		          }
		      ]
		    };

		    //console.log(option.xAxis);
		    // 
		    myPie.setOption(option); 
		  }
		);
	</script>
