package controllers.diaries;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Diary;

/**
 * Servlet implementation class DiariesNewServlet
 */
@WebServlet("/diaries/new")
public class DiariesNewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DiariesNewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("_token", request.getSession().getId());

        Diary r = new Diary();
        r.setDiary_date(new Date(System.currentTimeMillis()));
        request.setAttribute("diary", r);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/diaries/new.jsp");
        rd.forward(request, response);
    }

}
