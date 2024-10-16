<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        
        a:visited {
  			color: white;
		}
		
		li:hover a{
            color:black;
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
        <h1>쇼핑몰 회원관리 프로그램</h1>
        <p>
            쇼핑몰 회원정보...
        </p>
    </section>
    <footer>HRDKOREA Copyrihgt</footer>
</body>
</html>