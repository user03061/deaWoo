package DAO;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PhonebookController")
public class PhonebookController extends HttpServlet {

    private PhonebookDAO dao = new PhonebookDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            insertPhonebook(request, response);
        } else if ("search".equals(action)) {
            searchPhonebook(request, response);
        } else if ("list".equals(action)) {
            listPhonebook(request, response);
        } else if ("update".equals(action)) {
            updatePhonebook(request, response);
        } else if ("delete".equals(action)) {
            deletePhonebook(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        doPost(request, response);
    }


    private void insertPhonebook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String hp = request.getParameter("hp");
        String memo = request.getParameter("memo");

        PhonebookVO pvo = new PhonebookVO(0, name, hp, memo);
        dao.insert(pvo);

        response.sendRedirect("PhonebookController?action=list");
    }


    private void searchPhonebook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<PhonebookVO> result = dao.search(keyword);

        request.setAttribute("list", result);
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

    private void listPhonebook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<PhonebookVO> list = dao.selectAll();
        request.setAttribute("list", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

    private void updatePhonebook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String hp = request.getParameter("hp");
        String memo = request.getParameter("memo");

        PhonebookVO pvo = new PhonebookVO(id, name, hp, memo);
        dao.update(pvo);

        response.sendRedirect("PhonebookController?action=list");
    }

    private void deletePhonebook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.delete(id);

        response.sendRedirect("PhonebookController?action=list");
    }
}