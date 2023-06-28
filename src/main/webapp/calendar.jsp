<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.tjoeun.myCalendar.MyCalendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만년 달력
</title>

<style type="text/css">

	/* 식별자, 선택자  */
	
	table { border: 10px solid;  } /* border: 선두께 선종류 선색상 */
	
	tr { height: 70px; border-width: 0px; }
	th { font-size: 15pt; width: 100px; border-width: 0px; } 
	th#title { font-size: 25pt; font-family: D2Coding;  /* # -> id */
				font-weight: bold; color: fuchsia; }  /* 굵게 */
				
	th#sunday { color: red; }
	th#saturday { color : blue; }
	td#beforesun {color:red; font-size: 10pt;}
	
	td { text-align: right; vertical-align: top; border: 1px solid black; border-radius: 10px; } /* 수평, 수직 정렬 */
	td.sun { color: red; }
	td.sat { color: blue; }
	td.before { font-size: 10pt;}	
	
	td#aftersat { color: blue; font-size: 10pt; background-color: yellowgreen; }
	td.after { font-size: 10pt; background-color: yellowgreen; }
	td#choice { text-align: left; vertical-align: middle; }
	td.holiday { color: white; background-color: red; font-weight: bold; }
	
	span { font-size: 8pt; }
	
	
	/*
	하이퍼링크 스타일 지정하기
	link: 1번도 클릭하지 않은 하이퍼링크
	visited: 1번 이상 클릭한 하이퍼링크
	hover: 하이퍼링크에 마우스 올리고 있을 때
	active: 하이퍼링크를 마우스로 누르고 있을 때
	*/
	
/* 	a:link {
	color: black;
	text-decoration: none;
	font-size: 16pt;
}
	
	a:visited {
	color: black;
	text-decoration: none;
	font-size: 16pt;
}	 */
	
	/* a:link와 a:visited에 같은 서식이 적용되므로 ","로 나열해서 스타일 지정 가능 */
	
	a:link, a:visited {
	color: black; text-decoration: none; /* 밑줄 */	
}
	
	a:hover {
	color: lime;
	text-decoration: underline;	
}

	a:active {
	color: dodgerblue;
	text-decoration: overline;	
}

.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 5px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 0px;
  transition-duration: 0.4s;
  cursor: pointer;
}

.button1 {
  background-color: white; 
  color: black; 
  border: 2px solid #4CAF50;
}

.button1:hover {
  background-color: #4CAF50;
  color: white;
}

.button2 {
  background-color: white; 
  color: black; 
  border: 2px solid #008CBA;
}

.button2:hover {
  background-color: #008CBA;
  color: white;
} 
  
.select {
	width: 100px;
	height: 30px;
}

fieldset {
	width: 105px;
	display: inline;
}


	
</style>


</head>
<form action="?">
<body>

<%
// 달력 메소드 테스트
/*	out.println(MyCalendar.isLeapYear(2023));
	out.println(MyCalendar.lastDay(2023, 5));
	out.println(MyCalendar.totalDay(2023, 5, 1));
	out.println(MyCalendar.weekDay(2023, 5, 1));
*/	

	// 컴퓨터 시스템의 년, 월을 얻어온다.
//	Date date = new Date();
//	int year = date.getYear() + 1900;
//	int month = date.getMonth() + 1;

	Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH) + 1;
//	out.println(year + "년 " + month + "월");

//	이전달, 다음달 하이퍼링크 또는 버튼을 클릭하면 get방식으로 넘어오는 달력을 출력할 년, 월을 받는다.
// 	달력이 최초로 실행되면 이전 페이지가 존재하지 X -> 온 것도 없고 줄 것도 없다. -> 예외처리필요
	try
	{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month에 13이 넘어오면 달력의 Array는 터지게 된다. -> 다음 해 1월을 표시해야 함.
		if (month >= 13)
		{
			year++; month = 1;
		}
		// 0이넘어오면 작년 12월을 표시
		else if (month <=0)
		{
			year--; month = 12;
		}
	}
	catch (NumberFormatException e)
	{
	}

%>
<!-- <marquee scrolldelay=5 scrollamount=200 behavior="alternate">  -->
	<table width = "700" border="1" align="center" cellpadding="5" cellspacing="0">
	<tr>
		<th>
			<!-- 
			<a> 태그가 설정한 문자열 -> href 속성에 지정한 곳으로 이동 
			href 속성에 "#"뒤에 id(해쉬)를 지정하면 현재 문서에서 id가 지정된 요소로 이동하고
			url(주소)가 지정되면 지정된 곳으로 이동한다.

			"?" 뒤에 이동하는 페이지로 전달할 데이터를 넘겨주는데 이 때 넘겨줄 데이터가 2건 이상이라면
			데이터 사이에 "&"를 넣어서 구분한다.
			"?" 뒤에는 띄어쓰기 불가.
			-->
			<%-- <a href="?year=<%=year%>&month<%=month - 1%>">이전달</a> --%>
			
			<input 
				class="button button1"
				type="button"
				value="이전달"
				onclick="location.href='?year=<%=year%>&month=<%=month - 1%>'" >
		</th>
		<th id="title" colspan="5">
				<marquee scrolldelay=5 scrollamount=2 behavior="alternate">
				<%=year%>년 <%=month%>월 
				</marquee>
		</th>
		<th>
			<%-- <a href="?year=<%=year%>&month<%=month + 1%>">다음달</a> --%>
			<button type="button"
				class="button button2"
				onclick="location.href='?year=<%=year%>&month=<%=month + 1%>'" >
				다음달
		</th>
	</tr>
	<tr>
		<th id="sunday">일</th> <!-- 앞에 스타일에 지정하여 100을 다 빼도 무관 -->
		<th>월</th>
		<th>화</th>
		<th>수</th>
		<th>목</th>
		<th>금</th>
		<th id="saturday">토</th>
	</tr>
	
	<!-- 달력에 날짜를 출력한다.  -->
	<tr>
<%

	int week = MyCalendar.weekDay(year, month, 1);
	// 1일이 출력될 위치(요일)를 맞춘다.
/*
	for (int i=1 ; i <= MyCalendar.weekDay(year, month, 1) ; i++)
	{
		out.println("<td>&nbsp;</td>");
	}
*/
	int start = 0;
	
	// 12월, 1월 오류 처리
	if (month == 1)
	{
		// start = MyCalendar.lastDay(year -1, 12) - week; "둘 다 된다. 근데 어차피 31일인데 굳이?"
		start = 31 - week;
	}
	else
	{
		start = MyCalendar.lastDay(year, month-1) - week; // 2~ 12 월
	}
	
	for (int i=0 ; i<week; i++)
	{
		if (i== 0)
		{
			out.println("<td id='beforesun'>" + (month == 1 ? 12: month - 1) + "/" + (++start) + "</td>");
		}
		else
		{
			out.println("<td class='before'>" + (month == 1 ? 12: month - 1) + "/" + (++start) + "</td>");
		}
	}

	// 1일부터 달력을 출력할 달의 마지막 날까지 반복하며 날짜를 출력
	for (int i=1 ; i <= MyCalendar.lastDay(year, month) ; i++)
	{

/*
		if (MyCalendar.weekDay(year, month, i) == 0)
		{
			out.println("<td class='sun'>" + i + "</td>");
		}
		
		
		else if (MyCalendar.weekDay(year, month, i) == 6)
		{
			out.println("<td class='sat'>" + i + "</td>");
		}
		
		
		else
		{
			out.println("<td>" + i + "</td>");
		}
*/

		// 공휴일이 토요일또는 일요일과 겹치는 경우 그 다음 첫 번쨰 비 공휴일을 대체 공휴일로
		
		boolean flag0301 = false;
		int subHoliday0301 = 0;
		if (MyCalendar.weekDay(year, 3, 1) == 6)
		{
			flag0301 = true;
			subHoliday0301 = 3;
		}
		else if (MyCalendar.weekDay(year, 3, 1) == 0)
		{
			flag0301 = true;
			subHoliday0301 = 2;
		}

		boolean flag0505 = false;
		int subHoliday0505 = 0;
		if (MyCalendar.weekDay(year, 5, 5) == 6)
		{
			flag0505 = true;
			subHoliday0505 = 7;
		}
		else if (MyCalendar.weekDay(year, 5, 5) == 0)
		{
			flag0505 = true;
			subHoliday0505 = 6;
		}

		boolean flag0815 = false;
		int subHoliday0815 = 0;
		if (MyCalendar.weekDay(year, 8, 15) == 6)
		{
			flag0815 = true;
			subHoliday0815 = 17;
		}
		else if (MyCalendar.weekDay(year, 8, 15) == 0)
		{
			flag0815 = true;
			subHoliday0815 = 16;
		}

		boolean flag1003 = false;
		int subHoliday1003 = 0;
		if (MyCalendar.weekDay(year, 10, 3) == 6)
		{
			flag1003 = true;
			subHoliday1003 = 5;
		}
		else if (MyCalendar.weekDay(year, 10, 3) == 0)
		{
			flag1003 = true;
			subHoliday1003 = 4;
		}

		boolean flag1009 = false;
		int subHoliday1009 = 0;
		if (MyCalendar.weekDay(year, 10, 9) == 6)
		{
			flag1009 = true;
			subHoliday1009 = 11;
		}
		else if (MyCalendar.weekDay(year, 10, 9) == 0)
		{
			flag1009 = true;
			subHoliday1009 = 10;
		}

		boolean flag1225 = false;
		int subHoliday1225 = 0;
		if (MyCalendar.weekDay(year, 12, 25) == 6)
		{
			flag1225 = true;
			subHoliday1225 = 27;
		}
		else if (MyCalendar.weekDay(year, 12, 25) == 0)
		{
			flag1225 = true;
			subHoliday1225 = 26;
		}

		// 양력 공휴일
		if (month ==1 && i == 1)
		{out.println("<td class='holiday'>" + i + "<br><span>신정</span></td>");}
		else if (month ==3 && i == 1)
		{out.println("<td class='holiday'>" + i + "<br><span>삼일절</span></td>");}
		else if (month ==5 && i == 1)
		{out.println("<td class='holiday'>" + i + "<br><span>근로자의날</span></td>");}
		else if (month ==5 && i == 5)
		{out.println("<td class='holiday'>" + i + "<br><span>어린이날</span></td>");}
		else if (month ==6 && i == 6)
		{out.println("<td class='holiday'>" + i + "<br><span>현충일</span></td>");}
		else if (month ==8 && i == 15)
		{out.println("<td class='holiday'>" + i + "<br><span>광복절</span></td>");}
		else if (month ==10 && i == 3)
		{out.println("<td class='holiday'>" + i + "<br><span>개천절</span></td>");}
		else if (month ==10 && i == 9)
		{out.println("<td class='holiday'>" + i + "<br><span>한글날</span></td>");}
		else if (month ==12 && i == 25)
		{out.println("<td class='holiday'>" + i + "<br><span>성탄절</span></td>");}
		
		// 대체 공휴일
		else if (flag0301 && month == 3 && i == subHoliday0301)
		{
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		}

		else if (flag0505 && month == 5 && i == subHoliday0505)
		{
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		}
		else if (flag0815 && month == 8 && i == subHoliday0815)
		{
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		}
		else if (flag1003 && month == 10 && i == subHoliday1003)
		{
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		}
		else if (flag1009 && month == 10 && i == subHoliday1009)
		{
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		}
		else if (flag1225 && month == 12 && i == subHoliday1225)
		{
			out.println("<td class='holiday'>" + i + "<br><span>대체공휴일</span></td>");
		}
		
		// 공휴일을 제외한 나머지 날짜
		else
		{
			switch (MyCalendar.weekDay(year, month, i))
			{
				case 0:
					out.println("<td class='sun'>" + i + "</td>");
					break;
				case 6:
					out.println("<td class='sat'>" + i + "</td>");
					break;
				default:
					out.println("<td>" + i + "</td>");
					break;
			}
		}
		
		//	출력할 날짜가 토요일 && 달의 마지막 날짜가 아니면 줄 바꿈
		if (MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month))
		{
			out.println("</tr><tr>");
		}
	}
	
// 다음달 1일의 요일을 계산한다.
	if (month == 12)
	{
		week = MyCalendar.weekDay(year + 1, 1, 1); // 12월
	}
	else
	{
		week = MyCalendar.weekDay(year, month + 1, 1);
	}

// 다음달 1일이 일요일이면 남는 빈 칸이 없으므로 다음달 날짜를 출력할 필요가 없다.

	if (week != 0)
	{
	// 날짜를 다 출력하고 남은 빈 칸에 다음달 날짜를 다음달 1일의 요일부터 토요일까지 반복 출력한다.
		start = 1;
		for (int i=week; i<=6 ; i++)
		{
			if (i == 6)
			{
				out.println("<td id='aftersat'>" + (month == 12 ? 1: month + 1) + "/" + (start++) + "</td>");
			}
			else
			{
				out.println("<td class='after'>" + (month == 12 ? 1: month + 1) + "/" + (start++) + "</td>");
			}
		}
	}
// <gif src=https://www.pinterest.co.kr/pin/841258405388691499/>
%>
	</tr>
	<!-- 년, 월을 선택하고 보기 버튼을 클릭하면 선택된 달의 달력으로 한번에 넘어가게 한다. -->
	<tr>
		<td id="choice" colspan="7">
			<fieldset style="width: 105px; display: inline;">
				<legend>년</legend>
			<select class="select" name="year">
<%
				for (int i=1900 ; i<=2100 ; i++)  
				{
					if (calendar.get(Calendar.YEAR) == i)
					{
						out.println("<option selected='selected'>" + i + "</option>");
					}
					else
					{
						out.println("<option>" + i + "</option>");
					}
				}
%>
			</select>
			</fieldset>
			<fieldset>
				<legend>월</legend>
			<select class="select" name="month">
<%
				for (int i=1 ; i<=12 ; i++)  
				{
					if (calendar.get(Calendar.MONTH) == i)
					{
						out.println("<option selected='selected'>" + i + "</option>");
					}
					else
					{
						out.println("<option>" + i + "</option>");
					}
				}
%>
			</select>
		</fieldset>	
		<input class="select" type="submit" value="보기";"/>	
		</form>
		</td>
	</tr>
	</table>
<!-- </marquee>  -->
	<marquee scrolldelay=5 scrollamount=20 behavior="alternate">
	<iframe src="https://giphy.com/embed/ScBR92Mm5fhQc" width="134" height="240" align="center" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/ScBR92Mm5fhQc"></a></p>
	</marquee>	
</body>
</html>