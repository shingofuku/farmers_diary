package controllers.diaries;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Diary;
import utils.DBUtil;

/**
 * Servlet implementation class DiariesIndexServlet
 */
@WebServlet("/diaries/index")
public class DiariesIndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DiariesIndexServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em = DBUtil.createEntityManager();

        int page;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (Exception e) {
            page = 1;
        }
        List<Diary> diaries = em.createNamedQuery("getAllDiaries", Diary.class)
                .setFirstResult(15 * (page - 1))
                .setMaxResults(15)
                .getResultList();

        long diaries_count = (long) em.createNamedQuery("getDiariesCount", Long.class)
                .getSingleResult();
        em.close();

        request.setAttribute("diaries", diaries);
        request.setAttribute("diaries_count", diaries_count);
        request.setAttribute("page", page);
        if (request.getSession().getAttribute("flush") != null) {
            request.setAttribute("flush", request.getSession().getAttribute("flush"));
            request.getSession().removeAttribute("flush");
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/diaries/index.jsp");
        rd.forward(request, response);
    }

}
