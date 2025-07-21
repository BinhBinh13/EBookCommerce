
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
import java.util.List;
import model.BillDetail;

@WebServlet(name="viewBillDetail", urlPatterns={"/viewbilldetail"})
public class viewBillDetail extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet viewBillDetail</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet viewBillDetail at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String id =  request.getParameter("bill_id");
        String total = request.getParameter("total_money");
        double total_money = Double.parseDouble(total);
        int bill_id = Integer.parseInt(id);
        System.out.println("id: "+bill_id);
        BillDAO od = new BillDAO();
        List<BillDetail> list = od.getAllBillDetail(bill_id);
        HttpSession session = request.getSession(true);
        session.setAttribute("data_detail", list);
        session.setAttribute("total_money", total_money);
        request.getRequestDispatcher("viewBillDetail.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
