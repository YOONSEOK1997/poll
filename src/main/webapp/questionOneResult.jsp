<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "model.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<%
	// Contoroller : request 분석 + model 호출
	int qnum = Integer.parseInt(request.getParameter("qnum"));

	// 1) questionOne
	QuestionDao questionDao = new QuestionDao();
	QuestionDto question = questionDao.selectQuestionByNum(qnum); 
	// 2) 1)의 itemList
	ItemDao itemDao = new ItemDao();
	ArrayList<ItemDto> itemList = itemDao.selectItemListbyQnum(qnum);
	// 3) 총투표수
	int totalCount = itemDao.selectItemCountByQnum(qnum);
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 결과</title>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        var data = google.visualization.arrayToDataTable([
            ['항목', '투표 수'],
            <% for(ItemDto i : itemList) { %>
                ['<%=i.getContent()%>', <%=i.getCount()%>],
            <% } %>
        ]);

        var options = {
            title: '투표 결과',
            chartArea: {width: '60%'},
        };

        var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
        chart.draw(data, options);
    }
</script>
<style>
    .container {
        width: 80%;
        max-width: 800px;
        margin: 50px auto; 
        text-align: center;
    }
    
    
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    th {
        background-color: #f4f4f4;
    }

   
    #chart_div {
        width: 100%;
        height: 400px;
        margin: 0 auto; 
    }
</style>
</head>
<body>
    <div class="container">
        <h1><%=qnum%>번 설문 투표결과</h1>

        <table>
            <tr>
                <td colspan="4"><strong>Q : <%=question.getTitle()%></strong></td>
            </tr>
            <tr>
                <td colspan="4"><strong>총 투표수 : <%=totalCount%></strong></td>
            </tr>
        </table>

        <!-- 차트 출력 -->
        <div id="chart_div"></div>
    </div>
</body>
</html>
