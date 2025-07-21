
package controller;

import dal.BillDAO;
import dal.BookDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.BillDetail;
import model.Book;

@WebServlet(name="viewBillDetail2", urlPatterns={"/viewbilldetail2"})
public class viewBillDetail2 extends HttpServlet {

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
        BookDAO bd = new BookDAO();
        List<Book> listBook = bd.getBooks();
        request.setAttribute("listBook", listBook);
        request.setAttribute("data_detail", list);
        request.setAttribute("total_money", total_money);
        request.getRequestDispatcher("viewBillDetail2.jsp").forward(request, response);
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
