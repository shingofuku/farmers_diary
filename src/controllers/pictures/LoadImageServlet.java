package controllers.pictures;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Picture;
import utils.DBUtil;

/**
 * Servlet implementation class LoadImageServlet
 */
@WebServlet("/loadImage")
public class LoadImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoadImageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        response.setContentType("image/jpeg");
        System.out.println("画像データ取得処理");
        EntityManager em = DBUtil.createEntityManager();
        Picture pi = em.find(Picture.class, id);
        byte[] data = pi.getImage();

        ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
        byteOut.write(data, 0, data.length);
        response.setContentType("image/jpeg");
        response.setContentLength(byteOut.size());
        OutputStream out = response.getOutputStream();
        out.write(byteOut.toByteArray());
        out.close();

    }

}
