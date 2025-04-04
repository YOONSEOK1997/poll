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
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>투표 결과</title>
    
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var ctx = document.getElementById('voteChart').getContext('2d');
            var voteChart = new Chart(ctx, {
                type: 'bar', // 막대 그래프 (다른 타입: 'pie', 'doughnut', 'line' 등)
                data: {
                    labels: [
                        <% for(ItemDto i : itemList) { %>
                            "<%=i.getContent()%>",
                        <% } %>
                    ],
                    datasets: [{
                        label: '투표 수',
                        data: [
                            <% for(ItemDto i : itemList) { %>
                                <%=i.getCount()%>,
                            <% } %>
                        ],
                        backgroundColor: 'rgba(54, 162, 235, 0.6)', // 막대 색상
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: { display: true, text: "투표 수" }
                        },
                        x: {
                            title: { display: true, text: "항목" }
                        }
                    }
                }
            });
        });
    </script>

    <style>
        /* 전체 컨테이너 가운데 정렬 */
        .container {
            max-width: 800px;
            margin: 50px auto;
            text-align: center;
        }

        /* 캔버스 크기 조정 */
        #chart-container {
            width: 100%;
            height: 400px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="mt-4"><%=qnum%>번 설문 투표결과</h1>

        <table class="table table-bordered mt-4">
            <thead class="table-light">
                <tr>
                    <th>번호</th>
                    <th>내용</th>
                    <th>투표 수</th>
                </tr>
            </thead>
            <tbody>
                <% for(ItemDto i : itemList) { %>
                    <tr>
                        <td><%=i.getInum()%></td>
                        <td><%=i.getContent()%></td>
                        <td><%=i.getCount()%></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <!-- 차트 출력 -->
        <div id="chart-container">
            <canvas id="voteChart"></canvas>
        </div>
    </div>

 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
