<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="DAO.PhonebookDAO"%>
<%@ page import="DAO.PhonebookVO"%>

<%
    // DAO 객체 생성
    PhonebookDAO dao = new PhonebookDAO();
    String action = request.getParameter("action");
    List<PhonebookVO> list = null;

    if ("search".equals(action)) {
        String keyword = request.getParameter("keyword");
        list = dao.search(keyword);
    } else {
        list = dao.selectAll();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>전화번호부 관리 시스템</title>
    <style>
        /* 테두리 제거 및 스타일 조정 */
        #inputForm, #searchForm, #listContainer, #detailContainer {
            margin: 20px;
            padding: 10px;
        }
        #inputForm, #detailContainer {
            border: 1px solid #ccc;
            padding: 20px;
        }
        #listContainer {
            border-top: 1px solid #ccc;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>

    <h1>전화번호부 관리 시스템</h1>

    <!-- 1. 전화번호 입력 폼 -->
    <div id="inputForm">
        <form action="PhonebookController" method="post">
            <input type="hidden" name="action" value="insert">
            <div>
                <label>이름:</label>
                <input type="text" name="name" required>
            </div>
            <div>
                <label>전화번호:</label>
                <input type="text" name="hp" required>
            </div>
            <div>
                <label>메모:</label>
                <input type="text" name="memo">
            </div>
            <button type="submit">전화번호 입력</button>
        </form>
    </div>

    <!-- 2. 검색 기능 -->
    <div id="searchForm">
        <h2>전화번호 검색</h2>
        <form action="PhonebookController" method="post">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" placeholder="이름 또는 전화번호 검색">
            <button type="submit">검색</button>
        </form>
    </div>

<div id="listContainer">
    <h2>전화번호부 목록</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>이름</th>
            <th>전화번호</th>
            <th>메모</th>
        </tr>
        <% if (list != null) { %>
            <% for (PhonebookVO phonebook : list) { %>
                <tr>
                    <td><%= phonebook.getId() %></td>
                    <td><%= phonebook.getName() %></td>
                    <td><%= phonebook.getHp() %></td>
                    <td><%= phonebook.getMemo() %></td>
                    <td>
                        <!-- 수정 및 삭제 폼 -->
                        <form action="PhonebookController" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="<%= phonebook.getId() %>">
                            <input type="text" name="name" value="<%= phonebook.getName() %>">
                            <input type="text" name="hp" value="<%= phonebook.getHp() %>">
                            <input type="text" name="memo" value="<%= phonebook.getMemo() %>">
                            <button type="submit">수정</button>
                        </form>
                        <form action="PhonebookController" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= phonebook.getId() %>">
                            <button type="submit">삭제</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        <% } else { %>
            <tr>
                <td colspan="5">목록이 없습니다.</td>
            </tr>
        <% } %>
    </table>
</div>

</body>
</html>