package dal;

import java.security.SecureRandom;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;
import java.sql.Timestamp;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import java.sql.CallableStatement;
import java.util.Random;
import utl.Constance;

public class loginDAO extends DBContext {

    public User getUserByRoles(String roles) {
        String sql = "Select * FROM [user] WHERE roles = '?'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, roles);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User(
                        rs.getInt("account_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("gender"),
                        rs.getString("roles"),
                        rs.getString("avatar_pics")
                );
                return user;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void Register(User user) {
        String sql = "INSERT INTO [user] (username, password, full_name, email, phone_number, gender, roles, avatar_pics) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getGender());
            ps.setString(7, user.getRoles());
            ps.setString(8, user.getAvatarPics());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public String generateOTP() { //Hàm sinh ra mã OTP
        SecureRandom random = new SecureRandom();
        int otp = random.nextInt(999999);
        return String.format("%06d", otp);
        /*%06d là định dạng nếu số 
        sinh ra không đủ 6 số thì sẽ lấy số 0 bù vào phần đầu vd: 4321 -> 004321.*/

    }

    public void saveOtpAndOtpExpireTime(int accountId, String otp, Timestamp otpExpireTime) {
        String sql = "Update [user] SET otp = ?, otpExpireTime = ? Where account_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountId);
            ps.setTimestamp(2, otpExpireTime);
            ps.setInt(3, accountId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void sendEmail(String recipientEmail, String subject, String message) {
        String fromEmail = "ebookvn123@gmail.com"; //email nguoi gui
        String password = "Cuong25092005@"; // mk email

        // Thiết lập thuộc tính cho kết nối với SMTP server
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        // Cấu hình session và xác thực
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Tạo đối tượng MimeMessage
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            msg.setSubject(subject);
            msg.setText(message);

            // Gửi email
            Transport.send(msg);
            System.out.println("Email đã được gửi thành công.");
        } catch (MessagingException e) {
            System.out.println(e);
        }
    }

    // Lấy OTP từ cơ sở dữ liệu theo ID người dùng
    public String getOtpByUserId(int accountId) {
        String query = "SELECT otp FROM users WHERE account_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, accountId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("otp");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;  // Nếu không tìm thấy OTP
    }

    // Lấy thời gian hết hạn của OTP từ cơ sở dữ liệu
    public Timestamp getOtpExpireTime(int accountId) {
        String query = "SELECT otpExpireTime FROM users WHERE account_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, accountId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getTimestamp("otpExpireTime");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;  // Nếu không tìm thấy thời gian hết hạn
    }

    public void updatePassword(int accountId, String newPassword) {
        String query = "UPDATE users SET password = ? WHERE account_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, newPassword);
            statement.setInt(2, accountId);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    public void resetPassword(String userEmail, String newPassword) { 
    String sql = "UPDATE [user] SET password = ? WHERE email = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, newPassword); // Cập nhật mật khẩu mới
        ps.setString(2, userEmail);   // Điều kiện tìm kiếm theo email
        int rowsUpdated = ps.executeUpdate(); // Thực thi truy vấn

        if (rowsUpdated > 0) {
            System.out.println("Mật khẩu đã được cập nhật thành công cho email: " + userEmail);
        } else {
            System.out.println("Không tìm thấy tài khoản với email: " + userEmail);
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi đặt lại mật khẩu: " + e.getMessage());
    }
}
     // Phương thức này gọi stored procedure sp_AuthenticateUser để xác thực tài khoản
    public User authenticateUserProcedure(String username, String password) {
        String sql = "{call sp_AuthenticateUser(?, ?)}";
        try {
            CallableStatement cs = connection.prepareCall(sql);
            cs.setString(1, username);
            cs.setString(2, password);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                // Vì stored procedure chỉ trả về account_id, username và roles, 
                // ta sẽ tạo đối tượng User với các giá trị còn lại để trống (hoặc null)
                User user = new User(
                    rs.getInt("account_id"),
                    rs.getString("username"),
                    rs.getString("password"),        // password
                    rs.getString("full_name"),        // fullName
                    rs.getString("email"),        // email
                    rs.getString("phone_number"),        // phoneNumber
                    rs.getString("gender"),        // gender
                    rs.getString("roles"),
                    rs.getString("avatar_pics")         // avatarPics
                );
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không xác thực được
    }
    
    public void deleteAccountWithId(int id){
        String sql = "DELETE FROM [user] WHERE account_id = ?";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("id: " + id);
        }
        catch(SQLException e){
            System.out.println(e);
        }
    }
    
    public boolean updateUser(User user) {
        String sql = "UPDATE [user] SET full_name = ?, email = ?, phone_number = ?, gender = ?, avatar_pics = ? WHERE account_id = ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhoneNumber());
            stmt.setString(4, user.getGender());
            stmt.setString(5, user.getAvatarPics()); // Storing avatar as base64 string
            stmt.setInt(6, user.getAccountId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row is updated
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM [user] WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("account_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("phone_number"),
                    rs.getString("gender"),
                    rs.getString("roles"),
                    rs.getString("avatar_pics")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error while fetching user by email: " + e.getMessage());
        }
        return null; // Return null if user not found
    } // Trả về null nếu không tìm thấy người dùng
    public class SendEmailForgotPassword {

    // Sinh mã OTP 6 chữ số
    public String getRandomOTP() {
        return String.format("%06d", new Random().nextInt(999999));
    }

    // Sinh chuỗi ngẫu nhiên (7 ký tự chữ hoa)
    public String getRandomString() {
        final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        StringBuilder sb = new StringBuilder(7);
        Random random = new Random();
        for (int i = 0; i < 7; i++) {
            sb.append(ALPHABET.charAt(random.nextInt(ALPHABET.length())));
        }
        return sb.toString();
    }

    // Gửi email xác nhận
    public boolean sendEmail(User user, String messageContent) {
        boolean isSuccess = false;
        String toEmail = user.getEmail();
        String fromEmail = Constance.SENDGMAIL_TK;
        String password = Constance.SENDGMAIL_MK;

        try {
            Properties properties = new Properties();
            properties.put("mail.smtp.host", "smtp.gmail.com");
            properties.put("mail.smtp.port", "587");
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("User Email Verification");
            message.setText(messageContent);

            Transport.send(message);
            isSuccess = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // Sinh mật khẩu mạnh ngẫu nhiên
    private final String UPPERCASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private final String LOWERCASE = "abcdefghijklmnopqrstuvwxyz";
    private final String DIGITS = "0123456789";
    private final String SPECIAL_CHARACTERS = "!@#$%^&*()-_=+<>?";
    private final String ALL_CHARACTERS = UPPERCASE + LOWERCASE + DIGITS + SPECIAL_CHARACTERS;
    private final int PASSWORD_LENGTH = 10;

    public String generateStrongPassword() {
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();

        // Đảm bảo có ít nhất một ký tự từ mỗi nhóm
        password.append(UPPERCASE.charAt(random.nextInt(UPPERCASE.length())));
        password.append(LOWERCASE.charAt(random.nextInt(LOWERCASE.length())));
        password.append(DIGITS.charAt(random.nextInt(DIGITS.length())));
        password.append(SPECIAL_CHARACTERS.charAt(random.nextInt(SPECIAL_CHARACTERS.length())));

        // Thêm các ký tự còn lại
        for (int i = 4; i < PASSWORD_LENGTH; i++) {
            password.append(ALL_CHARACTERS.charAt(random.nextInt(ALL_CHARACTERS.length())));
        }

        return shuffleString(password.toString());
    }

    // Trộn xáo chuỗi ngẫu nhiên để tăng tính bảo mật
    private String shuffleString(String input) {
        char[] chars = input.toCharArray();
        SecureRandom random = new SecureRandom();
        for (int i = chars.length - 1; i > 0; i--) {
            int j = random.nextInt(i + 1);
            char temp = chars[i];
            chars[i] = chars[j];
            chars[j] = temp;
        }
        return new String(chars);
    }
    
}
    public static void main(String[] args) {
        loginDAO lg = new loginDAO();
        
        System.out.println(lg.authenticateUserProcedure("Binhdz", "123456"));
    }
}
    

