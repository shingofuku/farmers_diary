package controllers.diaries;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Diary;
import models.Employee;
import utils.DBUtil;

/**
 * Servlet implementation class DiariesEditServlet
 */
@WebServlet("/diaries/edit")
public class DiariesEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DiariesEditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em = DBUtil.createEntityManager();

        Diary r = em.find(Diary.class, Integer.parseInt(request.getParameter("id")));

        em.close();

        Employee login_employee = (Employee) request.getSession().getAttribute("login_employee");
        if (login_employee.getId() == r.getEmployee().getId()) {
            request.setAttribute("diary", r);
            request.setAttribute("_token", request.getSession().getId());
            request.getSession().setAttribute("diary_id", r.getId());
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/diaries/edit.jsp");
        rd.forward(request, response);
    }

}
