package controllers.diaries;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Diary;
import models.Employee;
import models.validators.DiaryValidator;
import utils.DBUtil;

/**
 * Servlet implementation class DiariesCreateServlet
 */
@WebServlet("/diaries/create")
public class DiariesCreateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DiariesCreateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String _token = (String) request.getParameter("_token");
        if (_token != null && _token.equals(request.getSession().getId())) {
            EntityManager em = DBUtil.createEntityManager();
            System.out.println(request.getParameter("diary_date"));

            Diary r = new Diary();

            r.setEmployee((Employee) request.getSession().getAttribute("login_employee"));

            Date diary_date = new Date(System.currentTimeMillis());
            String rd_str = request.getParameter("diary_date");
            if (rd_str != null && !rd_str.equals("")) {
                diary_date = Date.valueOf(request.getParameter("diary_date"));
            }
            r.setDiary_date(diary_date);

            r.setTitle(request.getParameter("title"));
            r.setContent(request.getParameter("content"));
            r.setFixtures(request.getParameter("fixtures"));

            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            r.setCreated_at(currentTime);
            r.setUpdated_at(currentTime);

            List<String> errors = DiaryValidator.validate(r);
            if (errors.size() > 0) {
                em.close();

                request.setAttribute("_token", request.getSession().getId());
                request.setAttribute("diary", r);
                request.setAttribute("errors", errors);

                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/diaries/new.jsp");
                rd.forward(request, response);
            } else {
                em.getTransaction().begin();
                em.persist(r);
                em.getTransaction().commit();
                em.close();
                request.getSession().setAttribute("flush", "登録が完了しました。");

                response.sendRedirect(request.getContextPath() + "/diaries/index");
            }
        }
    }

}
