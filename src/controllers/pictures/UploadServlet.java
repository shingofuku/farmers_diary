package controllers.pictures;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import models.Picture;
import utils.DBUtil;

/**
 * Servlet implementation class Upload
 */
@WebServlet("/pictures/UploadServlet")
@MultipartConfig(maxFileSize = 10240000)
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Part p = request.getPart("file");
        byte[] data = getBytes(p.getInputStream());

        Picture pi = new Picture();

        EntityManager em = DBUtil.createEntityManager();
        em.getTransaction().begin();
        pi.setImage(data);
        String name = request.getParameter("name");
        pi.setName(name);
        em.persist(pi);
        em.getTransaction().commit();

        response.sendRedirect(request.getContextPath() + "/upload.jsp");
    }

    private byte[] getBytes(InputStream is) {
        ByteArrayOutputStream b = new ByteArrayOutputStream();
        OutputStream os = new BufferedOutputStream(b);
        int c;
        try {
            while ((c = is.read()) != -1) {
                os.write(c);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (os != null) {
                try {
                    os.flush();
                    os.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return b.toByteArray();
    }

}
