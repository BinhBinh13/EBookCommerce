

package controller;

import dal.BillDAO;
import dal.statisticDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Bill;

@WebServlet(name="RevenueStatisticServlet", urlPatterns={"/revenue"})
public class RevenueStatisticServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RevenueStatisticServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RevenueStatisticServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
     statisticDAO dao = new statisticDAO();
        
        // Lấy danh sách các năm có dữ liệu
        List<Integer> years = dao.getAvailableYears();
        
        // Lấy năm được chọn từ request, mặc định là năm hiện tại (2025)
        String yearParam = request.getParameter("year");
        int selectedYear = (yearParam != null && !yearParam.isEmpty()) ? Integer.parseInt(yearParam) : 2025;

        // Lấy dữ liệu chi tiết doanh thu theo năm
        List<Object[]> revenueDetails = dao.getRevenueDetailsByYear(selectedYear);

        // Tính tổng doanh thu theo tháng và tổng năm
        Map<Integer, Double> monthlyTotals = new HashMap<>();
        double yearlyTotal = 0.0;
        for (Object[] detail : revenueDetails) {
            int month = (int) detail[1];
            double totalMoney = (double) detail[2];
            monthlyTotals.put(month, monthlyTotals.getOrDefault(month, 0.0) + totalMoney);
            yearlyTotal += totalMoney;
        }

        // Tạo dữ liệu cho biểu đồ (tổng theo tháng)
        List<Object[]> revenueData = new ArrayList<>();
        for (Map.Entry<Integer, Double> entry : monthlyTotals.entrySet()) {
            revenueData.add(new Object[]{entry.getKey(), entry.getValue()});
        }

        // Lưu dữ liệu vào session
        HttpSession session = request.getSession(true);
        session.setAttribute("revenueData", revenueData);         // Dữ liệu biểu đồ
        session.setAttribute("revenueDetails", revenueDetails);   // Chi tiết từng ngày
        session.setAttribute("monthlyTotals", monthlyTotals);     // Tổng theo tháng
        session.setAttribute("yearlyTotal", yearlyTotal);         // Tổng theo năm
        session.setAttribute("years", years);
        session.setAttribute("selectedYear", selectedYear);

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("viewStatisticRevenue.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
