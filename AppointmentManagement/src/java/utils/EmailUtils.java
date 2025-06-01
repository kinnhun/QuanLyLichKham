package utils;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailUtils {

    private static final String FROM_EMAIL = "trungkien2981412@gmail.com";
    private static final String APP_PASSWORD = "jssa nrmt rbwm jphj";

    // Hàm gửi email chung
    public static boolean sendEmail(String to, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Medicio Phòng khám"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
            message.setContent(content, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("✅ Gửi email thành công tới: " + to);
            return true;

        } catch (Exception e) {
            System.err.println("❌ Gửi mail thất bại: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // === 1️⃣ Gửi mail Quên mật khẩu ===
    public static boolean sendForgotPasswordEmail(String to, String resetLink) {
        String subject = "Yêu cầu đặt lại mật khẩu - Medicio Phòng khám";
        String content = "<h3>Xin chào,</h3>"
                + "<p>Bạn đã yêu cầu đặt lại mật khẩu.</p>"
                + "<p>Vui lòng bấm vào liên kết sau để tạo mật khẩu mới:</p>"
                + "<p><a href='" + resetLink + "'>Đặt lại mật khẩu</a></p>"
                + "<p>Liên kết có hiệu lực trong 15 phút.</p>"
                + "<p>Trân trọng,<br>Medicio Phòng khám</p>";

        return sendEmail(to, subject, content);
    }

    // === 2️⃣ Gửi mail Chúc mừng đăng ký thành công ===
    public static boolean sendWelcomeEmail(String to, String fullname) {
        String subject = "Chào mừng bạn đến với Medicio!";
        String content = "<h3>Xin chào " + fullname + ",</h3>"
                + "<p>Cảm ơn bạn đã đăng ký tài khoản tại Medicio.</p>"
                + "<p>Chúng tôi rất vui được đồng hành cùng bạn trong hành trình chăm sóc sức khỏe.</p>"
                + "<p>Trân trọng,<br>Medicio Phòng khám</p>";

        return sendEmail(to, subject, content);
    }

    // === 3️⃣ Gửi mail Xác nhận đổi mật khẩu thành công ===
    public static boolean sendPasswordChangedEmail(String to) {
        String subject = "Xác nhận thay đổi mật khẩu thành công - Medicio";
        String content = "<h3>Xin chào,</h3>"
                + "<p>Bạn vừa thay đổi mật khẩu tài khoản thành công.</p>"
                + "<p>Nếu bạn KHÔNG thực hiện thao tác này, vui lòng liên hệ bộ phận hỗ trợ ngay lập tức.</p>"
                + "<p>Trân trọng,<br>Medicio Phòng khám</p>";

        return sendEmail(to, subject, content);
    }

    // === 4️⃣ Gửi mail khi đăng nhập Google lần đầu → tạo tài khoản ===
    public static boolean sendGoogleRegisterInfoEmail(String to, String fullName, String username, String rawPassword) {
        String subject = "Thông tin tài khoản Medicio sau khi đăng nhập Google thành công";

        String content = "<h3>Xin chào " + fullName + ",</h3>"
                + "<p>Bạn vừa đăng nhập bằng tài khoản Google và hệ thống đã tạo tài khoản cho bạn.</p>"
                + "<p><strong>Thông tin tài khoản:</strong></p>"
                + "<ul>"
                + "<li>Username: " + username + "</li>"
                + "<li>Mật khẩu: " + rawPassword + "</li>"
                + "</ul>"
                + "<p>Bạn có thể đăng nhập trực tiếp trên website hoặc tiếp tục đăng nhập qua Google.</p>"
                + "<p>Trân trọng,<br>Medicio Phòng khám</p>";

        return sendEmail(to, subject, content);
    }

}
