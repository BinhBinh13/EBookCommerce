<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard - BookJar</title>
        <style>
            /* -----------------------------
       1. RESET & CƠ BẢN
    ----------------------------- */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
            }

            a {
                text-decoration: none;
                color: inherit;
            }

            /* -----------------------------
       2. HEADER BookJar
    ----------------------------- */
            .top-nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #ffffff;
                padding: 10px 30px;
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
            }

            .top-nav .logo {
                font-size: 24px;
                font-weight: bold;
                color: #333;
            }

            .top-nav .nav-links ul {
                list-style: none;
                display: flex;
                gap: 20px;
            }

            .top-nav .nav-links ul li a {
                font-size: 16px;
                color: #333;
                transition: color 0.3s;
            }

            .top-nav .nav-links ul li a:hover {
                color: #007bff;
            }

            /* -----------------------------
       3. CONTAINER CHUNG (Flex layout)
    ----------------------------- */
            .container {
                display: flex;
                height: calc(100vh - 60px);
                /* trừ chiều cao header */
            }

            /* -----------------------------
       4. SIDEBAR (Dashboard)
    ----------------------------- */
            .sidebar {
                width: 250px;
                /* Chiều rộng ban đầu */
                background-color: #2C3E50;
                color: white;
                padding: 20px;
                overflow-y: auto;
                transition: width 0.2s ease;
            }

            .sidebar h2 {
                text-align: center;
                margin-bottom: 30px;
                font-size: 24px;
                font-weight: bold;
                letter-spacing: 2px;
            }

            .sidebar ul {
                list-style: none;
                padding: 0;
            }

            .sidebar ul li {
                margin: 15px 0;
            }

            .sidebar ul li a {
                display: block;
                padding: 10px;
                font-size: 18px;
                color: #ecf0f1;
                border-radius: 5px;
                transition: all 0.3s ease;
            }

            .sidebar ul li a:hover {
                background-color: #3498db;
                transform: scale(1.05);
            }

            .dropdown-btn {
                cursor: pointer;
                display: block;
                padding: 12px;
                font-size: 18px;
                background: #2C3E50;
                color: white;
                border: none;
                width: 100%;
                text-align: left;
                margin-bottom: 10px;
                border-radius: 5px;
                transition: all 0.3s ease;
            }

            .dropdown-btn:hover {
                background: #3498db;
            }

            .dropdown-container {
                display: none;
                background-color: #34495E;
                padding-left: 20px;
                margin-top: 10px;
            }

            .dropdown-container a {
                padding: 8px 10px;
                font-size: 16px;
                color: #ecf0f1;
            }

            .dropdown-container a:hover {
                background-color: #2980b9;
            }

            /* -----------------------------
       5. RESIZE HANDLE (Thanh kéo)
    ----------------------------- */
            .resize-handle {
                width: 5px;
                background-color: #ccc;
                cursor: ew-resize;
            }

            /* -----------------------------
       6. MAIN CONTENT
    ----------------------------- */
            .main-content {
                flex: 1;
                padding: 20px;
                overflow-y: auto;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .container {
                    flex-direction: column;
                }

                .sidebar {
                    width: 100%;
                }

                .resize-handle {
                    display: none;
                }

                .main-content {
                    margin-left: 0;
                }
            }
        </style>
        <script>
            // Hàm mở/đóng dropdown trong sidebar
            function toggleDropdown(id) {
                var dropdown = document.getElementById(id);
                if (dropdown.style.display === "none" || dropdown.style.display === "") {
                    dropdown.style.display = "block";
                } else {
                    dropdown.style.display = "none";
                }
            }

            // Hàm kiểm tra xem nội dung iframe có báo lỗi 404 hay không
            function checkIframeForError(iframe) {
                try {
                    var doc = iframe.contentDocument || iframe.contentWindow.document;
                    if (doc && doc.body) {
                        if (doc.body.innerText.indexOf("404") !== -1) {
                            return true;
                        }
                    }
                } catch (e) {
                    return true;
                }
                return false;
            }

            // Xử lý khi iframe tải xong
            function handleIframeLoad() {
                var iframe = document.getElementsByName('contentFrame')[0];
                var errorDiv = document.getElementById('errorDiv');
                if (checkIframeForError(iframe)) {
                    iframe.style.display = 'none';
                    errorDiv.style.display = 'block';
                } else {
                    iframe.style.display = 'block';
                    errorDiv.style.display = 'none';
                }
            }

            window.addEventListener('DOMContentLoaded', function () {
                var iframe = document.getElementsByName('contentFrame')[0];
                iframe.onload = handleIframeLoad;

                // Hàm load nội dung cho iframe dựa trên hash
                function loadContentFromHash() {
                    var hash = window.location.hash;
                    var target = hash ? hash.substring(1) : "view_adminInfo.jsp";
                    iframe.src = target;
                }

                window.addEventListener('hashchange', loadContentFromHash);
                loadContentFromHash();

                document.querySelectorAll('.nav-link').forEach(function (link) {
                    link.addEventListener('click', function (e) {
                        e.preventDefault();
                        var targetHash = this.getAttribute('href');
                        window.location.hash = targetHash;
                    });
                });

                // Xử lý kéo thả để thay đổi độ rộng của sidebar
                var isResizing = false;
                var sidebar = document.querySelector('.sidebar');
                var resizeHandle = document.querySelector('.resize-handle');

                resizeHandle.addEventListener('mousedown', function (e) {
                    isResizing = true;
                    document.body.style.cursor = 'ew-resize';
                });

                document.addEventListener('mousemove', function (e) {
                    if (!isResizing)
                        return;
                    var newWidth = e.clientX;
                    newWidth = Math.max(150, Math.min(newWidth, 500));
                    sidebar.style.width = newWidth + 'px';
                });

                document.addEventListener('mouseup', function (e) {
                    if (isResizing) {
                        isResizing = false;
                        document.body.style.cursor = 'default';
                    }
                });

                // Xử lý sự kiện đăng xuất từ header và sidebar
                document.querySelectorAll('.logoutLink').forEach(function (link) {
                    link.addEventListener('click', function (e) {
                        e.preventDefault();
                        // Xóa thanh dashboard (sidebar và resize handle)
                        var sideBarElement = document.querySelector('.sidebar');
                        var resizeHandleElement = document.querySelector('.resize-handle');
                        if (sideBarElement) {
                            sideBarElement.remove();
                        }
                        if (resizeHandleElement) {
                            resizeHandleElement.remove();
                        }
                        // Cập nhật header (nếu cần, ví dụ thay đổi text nút)
                        var headerHome = document.getElementById('headerHome');
                        var headerLogout = document.getElementById('headerLogout');
                        if (headerHome) {
                            headerHome.textContent = 'Register';
                            headerHome.href = 'register.jsp';
                        }
                        if (headerLogout) {
                            headerLogout.textContent = 'Login';
                            headerLogout.href = 'login_test.jsp';
                        }
                        // Sau đó chuyển hướng URL sang trang homepage.jsp
                        window.location.href = "logout";
                    });
                });
            });
        </script>
    </head>

    <body>
        <!-- HEADER BookJar -->
        <div class="top-nav">
            <div class="logo">BookJar</div>
            <div class="nav-links">
                <ul>
                    <li><a id="headerLogout" href="logout.jsp" class="logoutLink">Logout</a></li>
                </ul>
            </div>
        </div>

        <!-- CONTAINER CHUNG: SIDEBAR, RESIZE HANDLE & MAIN CONTENT -->
        <div class="container">
            <!-- SIDEBAR -->
            <div class="sidebar">
                <h2>Admin Dashboard</h2>
                <ul>
                    <li><a href="#view_adminInfo.jsp" class="nav-link">Thông Tin Admin</a></li>
                    <li>
                        <button class="dropdown-btn" onclick="toggleDropdown('bookDropdown')">Quản Lý Sách</button>
                        <div id="bookDropdown" class="dropdown-container">
                            <a href="#adminbooklist" class="nav-link">Danh sách các quyển sách</a>
                            <a href="#admincategorylist" class="nav-link">Danh sách các thể loại sách</a>
                            <a href="#adminsupplierlist" class="nav-link">Danh sách các nhà xuất bản</a>
                        </div>
                    </li>

                    <li><button class="dropdown-btn" onclick="toggleDropdown('orderDropdown')">Quản Lý Đơn Hàng</button>
                        <div id="orderDropdown" class="dropdown-container">
                            <a href="viewbill" target="contentFrame">Xem Đơn</a>
                            <a href="searchBill.jsp" target="contentFrame">Tìm đơn</a>
                        </div>
                    </li>
                    <li>
                        <a href="#userList" class="nav-link">Danh Sách Người Dùng</a>
                    </li>
                    <li>
                        <button class="dropdown-btn" onclick="toggleDropdown('statsDropdown')">Thống Kê</button>
                        <div id="statsDropdown" class="dropdown-container">
                            <a href="bestseller" class="nav-link">Thống Kê Sách Bán Chạy</a>
                            <a href="revenue" class="nav-link">Thống Kê Doanh Thu</a>
                        </div>
                    </li>
                    <li><a id="sidebarLogout" href="logout" class="nav-link logoutLink">Đăng Xuất</a></li>
                </ul>
            </div>

            <!-- PHẦN KÉO THẢ: RESIZE HANDLE -->
            <div class="resize-handle"></div>

            <!-- MAIN CONTENT -->
            <div class="main-content">
                <div id="errorDiv"
                     style="display:none; padding:20px; text-align:center; font-size:24px; color:#e74c3c;">
                    404 - Trang bạn yêu cầu không tồn tại.
                </div>
                <iframe name="contentFrame" src="view_adminInfo.jsp"
                        style="width:100%; height:100%; border:none;"></iframe>
            </div>
        </div>
    </body>

</html>