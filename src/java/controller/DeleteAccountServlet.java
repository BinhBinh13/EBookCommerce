

package controller;

import dal.loginDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="DeleteAccountServlet", urlPatterns={"/delete"})
public class DeleteAccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String mess;
        String id_ = request.getParameter("accountId");
        System.out.println(id_);
        int id = Integer.parseInt(id_);
        loginDAO ld = new loginDAO();
        ld.deleteAccountWithId(id);
        mess="Delete account Succesfully!";
        request.getSession().removeAttribute("currentUser");
        request.setAttribute("result", mess);
        response.sendRedirect("home.jsp");
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
