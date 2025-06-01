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

    // Template HTML đẹp cho tất cả email
    private static String buildEmailTemplate(String bodyContent) {
        return "<!DOCTYPE html>"
                + "<html lang='vi'>"
                + "<head>"
                + "    <meta charset='UTF-8'>"
                + "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                + "    <style>"
                + "        body { font-family: 'Arial', sans-serif; background-color: #f0f2f5; margin: 0; padding: 20px; }"
                + "        .email-container { max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1); }"
                + "        .email-header { background: linear-gradient(90deg, #3FBBC0, #38a8a4); padding: 20px; text-align: center; }"
                + "        .email-header img { max-width: 120px; margin-bottom: 10px; }"
                + "        .email-header h1 { color: #ffffff; font-size: 24px; margin: 0; letter-spacing: 1px; }"
                + "        .email-body { padding: 30px; color: #333333; font-size: 16px; line-height: 1.8; }"
                + "        .email-footer { padding: 20px; text-align: center; font-size: 14px; color: #777777; background-color: #fafafa; border-top: 1px solid #eaeaea; }"
                + "        .email-footer p { margin: 5px 0; }"
                + "        .btn { display: inline-block; padding: 14px 28px; background-color: #3FBBC0; color: #ffffff; text-decoration: none; border-radius: 6px; margin: 20px 0; font-weight: bold; font-size: 16px; }"
                + "        .btn:hover { background-color: #36a7ab; }"
                + "        ul { padding-left: 20px; }"
                + "    </style>"
                + "</head>"
                + "<body>"
                + "    <div class='email-container'>"
                + "        <div class='email-header'>"
                + "            <h1>Medicio Phòng khám</h1>"
                + "        </div>"
                + "        <div class='email-body'>"
                + bodyContent
                + "        </div>"
                + "        <div class='email-footer'>"
                + "            <p>© 2025 Medicio. All rights reserved.</p>"
                + "            <p>Địa chỉ: 123 Đường ABC, Quận XYZ, TP. Hà Nội</p>"
                + "            <p>Hotline: <a href='tel:+84901234567' style='color: #3FBBC0; text-decoration: none;'>0901 234 567</a> | "
                + "            Website: <a href='https://medicio.vn' style='color: #3FBBC0; text-decoration: none;'>medicio.vn</a></p>"
                + "        </div>"
                + "    </div>"
                + "</body>"
                + "</html>";
    }

    // 1️⃣ Quên mật khẩu
    public static boolean sendForgotPasswordEmail(String to, String resetLink) {
        String subject = "Yêu cầu đặt lại mật khẩu - Medicio Phòng khám";
        String bodyContent = "<h3>Xin chào,</h3>"
                + "<p>Bạn đã yêu cầu đặt lại mật khẩu.</p>"
                + "<p>Vui lòng bấm vào nút dưới đây để tạo mật khẩu mới:</p>"
                + "<p style='text-align: center;'>"
                + "    <a href='" + resetLink + "' class='btn'>Đặt lại mật khẩu</a>"
                + "</p>"
                + "<p>Liên kết có hiệu lực trong 15 phút.</p>"
                + "<p>Trân trọng,<br>Medicio Phòng khám</p>";
        return sendEmail(to, subject, buildEmailTemplate(bodyContent));
    }

    // 2️⃣ Chúc mừng đăng ký
    public static boolean sendWelcomeEmail(String to, String fullname) {
        String subject = "Chào mừng bạn đến với Medicio!";
        String bodyContent = "<h3>Xin chào " + fullname + ",</h3>"
                + "<p>Cảm ơn bạn đã đăng ký tài khoản tại Medicio.</p>"
                + "<p>Chúng tôi rất vui được đồng hành cùng bạn trong hành trình chăm sóc sức khỏe.</p>"
                + "<p>Trân trọng,<br>Medicio Phòng khám</p>";
        return sendEmail(to, subject, buildEmailTemplate(bodyContent));
    }

    // 3️⃣ Đổi mật khẩu thành công
    public static boolean sendPasswordChangedEmail(String to) {
        String subject = "Xác nhận thay đổi mật khẩu thành công - Medicio";
        String bodyContent = "<h3>Xin chào,</h3>"
                + "<p>Bạn vừa thay đổi mật khẩu tài khoản thành công.</p>"
                + "<p>Nếu bạn KHÔNG thực hiện thao tác này, vui lòng liên hệ bộ phận hỗ trợ ngay lập tức.</p>"
                + "<p>Trân trọng,<br>Medicio Phòng khám</p>";
        return sendEmail(to, subject, buildEmailTemplate(bodyContent));
    }

    // 4️⃣ Đăng nhập Google lần đầu
    public static boolean sendGoogleRegisterInfoEmail(String to, String fullName, String username, String rawPassword) {
        String subject = "Thông tin tài khoản Medicio sau khi đăng nhập Google thành công";
        String bodyContent = "<h3>Xin chào " + fullName + ",</h3>"
                + "<p>Bạn vừa đăng nhập bằng tài khoản Google và hệ thống đã tạo tài khoản cho bạn.</p>"
                + "<p><strong>Thông tin tài khoản:</strong></p>"
                + "<ul>"
                + "    <li><strong>Username:</strong> " + username + "</li>"
                + "    <li><strong>Mật khẩu:</strong> " + rawPassword + "</li>"
                + "</ul>"
                + "<p>Bạn có thể đăng nhập trực tiếp trên website hoặc tiếp tục đăng nhập qua Google.</p>"
                + "<p>Trân trọng,<br>Medicio Phòng khám</p>";
        return sendEmail(to, subject, buildEmailTemplate(bodyContent));
    }

    // 5️⃣ Đặt lịch khám thành công
    public static boolean sendBookingSuccessEmail(String to, String patientName, String appointmentDate, String doctorName) {
        String subject = "Xác nhận đặt lịch khám thành công - Medicio";
        String bodyContent = "<h3>Xin chào " + patientName + ",</h3>"
                + "<p>Chúng tôi đã xác nhận lịch khám của bạn.</p>"
                + "<p><strong>Thời gian khám:</strong> " + appointmentDate + "</p>"
                + "<p><strong>Bác sĩ:</strong> " + doctorName + "</p>"
                + "<p>Vui lòng đến trước 10 phút để làm thủ tục.</p>"
                + "<p>Trân trọng,<br>Medicio Phòng khám</p>";
        return sendEmail(to, subject, buildEmailTemplate(bodyContent));
    }

    // 6️⃣ Hủy lịch khám
    public static boolean sendBookingCancelEmail(String to, String patientName, String appointmentDate) {
        String subject = "Thông báo hủy lịch khám - Medicio";
        String bodyContent = "<h3>Xin chào " + patientName + ",</h3>"
                + "<p>Lịch khám vào ngày <strong>" + appointmentDate + "</strong> của bạn đã được hủy theo yêu cầu.</p>"
                + "<p>Nếu bạn cần đặt lại lịch, vui lòng truy cập website của chúng tôi.</p>"
                + "<p>Trân trọng,<br>Medicio Phòng khám</p>";
        return sendEmail(to, subject, buildEmailTemplate(bodyContent));
    }

    // 7️⃣ Gửi hóa đơn
    public static boolean sendInvoiceEmail(String to, String patientName, String invoiceNumber, String amount, String paymentDate) {
        String subject = "Hóa đơn thanh toán - Medicio (Mã: " + invoiceNumber + ")";
        String bodyContent = "<h3>Xin chào " + patientName + ",</h3>"
                + "<p>Cảm ơn bạn đã sử dụng dịch vụ của Medicio.</p>"
                + "<p><strong>Mã hóa đơn:</strong> " + invoiceNumber + "</p>"
                + "<p><strong>Số tiền:</strong> " + amount + "</p>"
                + "<p><strong>Ngày thanh toán:</strong> " + paymentDate + "</p>"
                + "<p>Mọi thắc mắc xin vui lòng liên hệ bộ phận kế toán của chúng tôi.</p>"
                + "<p>Trân trọng,<br>Medicio Phòng khám</p>";
        return sendEmail(to, subject, buildEmailTemplate(bodyContent));
    }

}
