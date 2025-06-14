package controller;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.json.JsonFactory;

import dao.UserDAO;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

@WebServlet(name = "Oauth2HandlerController", urlPatterns = {"/oauth2handler"})
public class Oauth2HandlerController extends HttpServlet {

    private static final String CLIENT_ID = "20495276859-asgm8cn4636ehlrsktoc6klk7ldujrp5.apps.googleusercontent.com";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // gọi lại GET
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy credential token từ URL callback
        String credential = request.getParameter("credential");

        if (credential == null || credential.isEmpty()) {
            response.sendRedirect("login?error=Invalid Google login.");
            return;
        }

        try {
            JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();

            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
                    GoogleNetHttpTransport.newTrustedTransport(), jsonFactory)
                    .setAudience(Collections.singletonList(CLIENT_ID))
                    .build();

            GoogleIdToken idToken = verifier.verify(credential);

            if (idToken != null) {
                Payload payload = idToken.getPayload();

                // Lấy thông tin user từ Google token
                String email = payload.getEmail();
                String name = (String) payload.get("name");
                String pictureUrl = (String) payload.get("picture");

                // Kiểm tra trong DB
                UserDAO userDAO = new UserDAO();
                Users user = userDAO.getUserByEmail(email);

                if (user == null) {
                    // Nếu user chưa có → tạo mới
                    user = new Users();

// Cắt username từ email
                    String usernamePart = email.substring(0, email.indexOf("@"));
                    String finalUsername = usernamePart;
                    int counter = 1;

// Nếu username đã tồn tại → thêm hậu tố
                    while (userDAO.isUsernameExists(finalUsername)) {
                        finalUsername = usernamePart + counter;
                        counter++;
                    }

                    user.setUsername(finalUsername);

                    user.setEmail(email);
                    user.setFullName(name);
                    user.setPasswordHash("123456");
                    user.setPhone(""); // Chưa có
                    user.setRole("Patient");
                    user.setIsActive(true);
                    user.setNote("Tài khoản tạo từ Google Login");

                    boolean success = userDAO.registerUser(user);
                    if (!success) {
                        response.sendRedirect("login?error=Không thể tạo tài khoản Google.");
                        return;
                    } else {
                        utils.EmailUtils.sendGoogleRegisterInfoEmail(user.getEmail(), user.getFullName(), user.getUsername(), "123456");

                    }
                }

                // Đăng nhập thành công → lưu session
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);

                response.sendRedirect(userDAO.responsePage(user.getRole()));

            } else {
                response.sendRedirect("login?error=Invalid ID token.");
            }

        } catch (GeneralSecurityException | IOException e) {
            e.printStackTrace();
            response.sendRedirect("login?error=Google login error.");
        }
    }

    @Override
    public String getServletInfo() {
        return "OAuth2 Google Login Handler";
    }
}
