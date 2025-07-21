
package controller;

import dal.BillDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Bill;

@WebServlet(name="SearchBillServlet", urlPatterns={"/checkbill"})
public class SearchBillServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchBillServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchBillServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("searchBill.jsp");
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String account_id1 = request.getParameter("account_id");
        System.out.println(account_id1);
        String mess;
        HttpSession session = request.getSession();
        BillDAO od = new BillDAO();
       
        try{
            int account_id = Integer.parseInt(account_id1);
            List<Bill> list = od.getBillByAccount(account_id);
            if(list == null || list.isEmpty()){
                mess = "This account dont have any bill!";
                System.out.println("Not found");
                session.removeAttribute("data3");
                request.setAttribute("error", mess);
                request.getRequestDispatcher("searchBill.jsp").forward(request, response);
            }
            else{
                System.out.println("Found");
                session.setAttribute("data3", list);
                request.getRequestDispatcher("searchBill.jsp").forward(request, response);
            }
            
        }
        catch(NumberFormatException e){
            System.out.println("Wrong input");
            mess = "Invalid account ID ! Please try again.";
            request.setAttribute("error", mess);
            session.removeAttribute("data3");
            request.getRequestDispatcher("searchBill.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
