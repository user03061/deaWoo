<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn
=DriverManager.getConnection
("jdbc:oracle:thin:@localhost:1521:xe","system","1234");
StringBuffer sql=new StringBuffer();
sql.append("select a.custno custno, a.custname custname");
sql.append(",a.grade grade, sum(b.price) price");
sql.append(" from MEMBER_TBL_02 a, money_tbl_02 b"); 
sql.append(" where a.custno=b.custno");
sql.append(" group by (a.custno, a.custname, a.grade)");
sql.append(" order by price desc");
PreparedStatement ps=
conn.prepareStatement(sql.substring(0)); //sql.toString()
ResultSet rs=ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
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
        
        setion > p > table > tr > th, td{
        text-align: center;
        }
        table{
        margin-left:auto;
        margin-right:auto;
        width:80%;
        }
    </style>
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
        <h1>회원목록조회/수정</h1>
        <p>
            <table border="1">
            	<tr>
            		<th>회원번호</th>
            		<th>회원성명</th>
            		<th>고객등급</th>
            		<th>매출</th>
            	</tr>
            	<%while(rs.next()){ 
            		int custno=rs.getInt("custno");
            		String custname=rs.getString("custname");
            		String grade=rs.getString("grade");
            		int price=rs.getInt("price");            		
            	%>
            	<tr>
            		<td><%=custno%></td>
            		<td><%=custname%></td>
            		<td><%=grade.equals("A") ? "VIP": grade.equals("B")?"직원":"일반"%></td>
            		<td><%=price%></td>
            	</tr>
            	<% } %>
            </table>
        </p>
    </section>
    <footer>HRDKOREA Copyrihgt</footer>
</body>
</html>