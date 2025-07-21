package controller;

import dal.statisticDAO;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name="BestSellerStatisticServlet", urlPatterns={"/bestseller"})
public class BestSellerStatisticServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        statisticDAO sd = new statisticDAO();
        HttpSession session = request.getSession();

        // Lấy danh sách năm khả dụng
        List<Integer> availableYears = sd.getAvailableYears();
        session.setAttribute("availableYears", availableYears);

        // Lấy tham số year từ request
        String yearParam = request.getParameter("year");
        List<Object[]> bookCounts;

        if (yearParam != null && !yearParam.isEmpty()) {
            try {
                int year = Integer.parseInt(yearParam);
                bookCounts = sd.getBookCountInBillsByYear(year);
            } catch (NumberFormatException e) {
                bookCounts = sd.getBookCountInBills(); // Nếu year không hợp lệ, lấy toàn bộ dữ liệu
            }
        } else {
            bookCounts = sd.getBookCountInBills();
        }

        // Sắp xếp bookCounts theo số lượng bán (quantity) giảm dần
        Collections.sort(bookCounts, new Comparator<Object[]>() {
            @Override
            public int compare(Object[] o1, Object[] o2) {
                Integer quantity1 = (Integer) o1[2];
                Integer quantity2 = (Integer) o2[2];
                return quantity2.compareTo(quantity1); // Sắp xếp giảm dần
            }
        });

        // Lưu danh sách đã sắp xếp vào session
        session.setAttribute("bestSellerList", bookCounts);

        // Chuyển tiếp đến JSP
        request.getRequestDispatcher("viewBestSellerStatistic.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response); // Xử lý POST giống như GET
    }

    @Override
    public String getServletInfo() {
        return "Servlet for Best Seller Statistics";
    }
}