<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
1.한글처리(request.setCharacterEncoding)
2.requst.getParameter함수를 이용하여 값 전달
3.전달된 값을 db입력
 -->
<% 
request.setCharacterEncoding("utf-8");

int custno
=Integer.parseInt(request.getParameter("custno"));
String custname=request.getParameter("custname");
String phone=request.getParameter("phone");
String address=request.getParameter("address");
String joindate=request.getParameter("joindate");
String grade=request.getParameter("grade");
String city=request.getParameter("city");
System.out.println
(custno+custname+phone+address+joindate+grade+city);

Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn
=DriverManager.getConnection
("jdbc:oracle:thin:@localhost:1521:xe","system","1234");

String sql="insert into member_tbl_02 values(?,?,?,?,?,?,?)";
PreparedStatement ps=conn.prepareStatement(sql);
ps.setInt(1,custno);
ps.setString(2,custname);
ps.setString(3,phone);
ps.setString(4,address);
ps.setString(5,joindate);
ps.setString(6,grade);
ps.setString(7,city);
ps.executeUpdate();
ps.close();
conn.close();
%>
<script>
history.back();
</script>