<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1)조회된 회원번호(custno)를 request받는다.
int custno=Integer.parseInt(request.getParameter("custno"));
//2)custno에 대한 정보조회
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn
=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","1234");
//System.out.println(conn);
String sql="select * from member_tbl_02 where custno=?";
PreparedStatement ps=conn.prepareStatement(sql);
ps.setInt(1, custno);
ResultSet rs=ps.executeQuery();
String custname="";
String phone="";
String address="";
String joindate="";
String grade="";
String city="";
if(rs.next()){
	custname=rs.getString("custname");
	phone=rs.getString("phone");
	address=rs.getString("address");
	joindate=rs.getString("joindate");
	grade=rs.getString("grade");
	city=rs.getString("city");
}
rs.close();
ps.close();
conn.close();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>regmember.jsp</title>
    <style>
        *{margin:0;padding:0;}
        header{
            background-color: rgb(0,0,255);
            color: white;
            text-align: center;
            margin:0;
            padding-top: 10px;
            padding-bottom: 10px;
        }

        ul{
            /* border: 1px solid red; */
            background-color: rgba(150,0,200,0.8);
        }
        li{
            /* border: 1px solid green; */
            display: inline-block;
            padding: 10px 16px;
            color:white;
        }
        li:hover{
            background-color: bisque;
            color:black;
            border-radius: 10px;
        }
        section{
            height: 400px;
        }

        section > h1{
            text-align: center;
        }
        footer{
            /* border:1px solid black;
            width: 100%;
            height: 100px;
            line-height: 100px; */
            text-align: center;
            background-color: rgb(0,0,255);
            color:white;
            font-size: 20px;
            padding: 30px 0;
        }
        
        section > p > table > tr > th,td{
        	text-align: center;
        }
        
        table{
        margin-left:auto;
        margin-right:auto;
        width:40%;
        }
    </style>
    <script>
    function confirm(){
    	/*	
    	var obj=document.getElementById("custno");
    	alert(obj.value);
    	return false;
    	*/
    	//유효성 검사(순서: 1)input 객체확인
    	//		-2)객체의value를 확인
    	//      [비어있는가,길이는 적합한가,형식은 적합한가]
    	//		-3)유효성확인 통과하면 db입력처리, 
    	//      그렇지 않으면 현재 페이지 문제가 있는 곳으로 이동)
    	var custno=document.getElementById("custno")
    	var custname=document.getElementById("custname")
    	var phone=document.getElementById("phone")
    	var address=document.getElementById("address")
    	var joindate=document.getElementById("joindate")
    	var grade=document.getElementById("grade")
    	var city=document.getElementById("city")
    	
    	if(custno.value==""){
    		alert("회원번호가 비어 있습니다.");
    		custno.focus();
    		return false;
    	}else if(custname.value==""){
    		alert("회원 이름이 비어 있습니다.");
    		custname.focus();
    		return false;
    	}else if(phone.value==""){
    		alert("회원 전화번호가 비어 있습니다.");
    		phone.focus();
    		return false;
    	}else if(address.value==""){
    		alert("회원 주소가 비어 있습니다.");
    		address.focus();
    		return false;
    	}else if(joindate.value==""){
    		alert("회원 가입일이 비어 있습니다.");
    		joindate.focus();
    		return false;
    	}else if(grade.value==""){
    		alert("회원 등급이 비어 있습니다.");
    		grade.focus();
    		return false;
    	}else if(city.value==""){
    		alert("회원 거주도시가 비어 있습니다.");
    		city.focus();
    		return false;
    	}
    	
    	alert('회원정보가 수정 되었습니다!')
    	//regmemberProc.jsp -> 
    	// updateformProc.jsp복사 후 수정처리
    }
    </script>
</head>
<body>
    <header>쇼핑몰 회원관리 ver 1.0</header>
    <nav>
        <ul>
            <li><a href="regmember.jsp">회원등록</a></li>
            <li><a href="memberlist.jsp">회원목록조회/수정</a></li>
            <li><a href="sale.jsp">회원매출</a></li>
            <li><a href="index.html">홈으로.</a></li>
        </ul>
    </nav>
    <section>
        <h1>홈쇼핑 회원정보 수정</h1>
        <p>
        	<form action="updateformProc.jsp" onsubmit="return confirm()"
        	method="post">
            <table border="1">
            <tr>
            	<td>회원번호</td>
            	<td><input type="text" name="custno" id="custno" value="<%=custno%>" readonly></td>
            </tr>
            <tr>
            	<td>회원성명</td>
            	<td><input type="text" name="custname" id="custname" value="<%=custname%>"></td>
            </tr>
            <tr>
            	<td>회원전화번호</td>
            	<td><input type="text" name="phone" id="phone" value="<%=phone%>"></td>
            </tr>
            <tr>
            	<td>회원주소</td>
            	<td><input type="text" name="address" id="address" value="<%=address%>"></td>
            </tr>
            <tr>
            	<td>가입일자</td>
            	<td><input type="text" name="joindate" id="joindate" value="<%=joindate%>"></td>
            </tr>
            <tr>
            	<td>고객등급[A:VIP,B:일반,c:직원]</td>
            	<td><input type="text" name="grade" id="grade" value="<%=grade%>"></td>
            </tr>
            <tr>
            	<td>도시코드</td>
            	<td><input type="text" name="city" id="city" value="<%=city%>"></td>
            </tr>
            <tr>
            	<td colspan="2">
            	<input type="submit" value="수정">
            	<input type="button" value="조회">
            	</td>
            </tr>
            </table>
            </form>
        </p>
    </section>
    <footer>HRDKOREA Copyrihgt</footer>
    
    <script>
    today = new Date();
    var _joindate=today.getFullYear()+
    ''+ ((today.getMonth()+1).length>1 
    	? today.getMonth()+1 :('0'+ (today.getMonth()+1)))
    +''+ (today.getDate().length>1 
    		? today.getDate():('0'+ today.getDate()))
    		
     document.getElementById("joindate").value=_joindate;  		
    </script>
    
</body>
</html>