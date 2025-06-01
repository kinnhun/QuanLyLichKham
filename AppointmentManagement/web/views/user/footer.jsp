<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <body>
        <footer id="footer" class="footer light-background">

            <div class="container footer-top">
                <!-- ... các cột footer của bạn ... -->
            </div>

            <div class="container copyright text-center mt-4">
                <p>© <span>Copyright</span> <strong class="px-1 sitename">Medicio</strong> <span>All Rights Reserved</span></p>
                <div class="credits">
                    Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a> Distributed by <a href="https://themewagon.com">ThemeWagon</a>
                </div>
            </div>
        </footer>

        <!-- 👇👈 Đặt include plugin-chat.jsp Ở NGOÀI FOOTER -->
<!-- plugin-chat.jsp -->
<!-- Chỉ để trống hoặc chỉ có dòng import JS: -->

        <!-- Vendor JS Files -->
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/php-email-form/validate.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/aos/aos.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/glightbox/js/glightbox.min.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/purecounter/purecounter_vanilla.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/swiper/swiper-bundle.min.js"></script>

        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/views/user/assets/js/main.js"></script>
        
        
        
  <style>
        /* Chat Widget Styles */
        #chat-widget {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 9999;
        }

        #chat-box {
            position: absolute;
            bottom: 80px;
            right: 0;
            width: 320px;
            height: 500px;
            background: #fff;
            border: 1px solid #ccc;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            overflow: hidden;
            display: none; /* Mặc định đóng */
            flex-direction: column;
            transition: all 0.3s ease;
        }

        #chat-box.open {
            display: flex;
        }

        #chat-box .header {
            background-color: #3FBBC0;
            color: white;
            padding: 10px;
            text-align: center;
            font-weight: bold;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
            position: relative;
        }

        #chat-close {
            position: absolute;
            top: 5px;
            right: 10px;
            background: transparent;
            border: none;
            color: white;
            font-size: 18px;
            cursor: pointer;
        }

        #chat-messages {
            flex: 1;
            padding: 10px;
            overflow-y: auto;
            background-color: #f9f9f9;
            display: flex;
            flex-direction: column;
        }

        #chat-messages .message {
            margin-bottom: 8px;
            padding: 8px 12px;
            border-radius: 12px;
            max-width: 80%;
            word-wrap: break-word;
            clear: both;
        }

        .user-message {
            background-color: #DCF8C6;
            align-self: flex-end;
            margin-left: auto;
            text-align: right;
        }

        .ai-message {
            background-color: #F1F0F0;
            align-self: flex-start;
            margin-right: auto;
            text-align: left;
        }

        .ai-loading-message {
            background-color: #eee;
            align-self: flex-start;
            margin-right: auto;
            text-align: left;
            font-style: italic;
        }

        #chat-suggestions-inline {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
        }

        #chat-suggestions-inline .suggestion-btn {
            padding: 6px 12px;
            background-color: #e0f7fa;
            border: 1px solid #3FBBC0;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
        }

        #chat-input {
            width: 100%;
            height: 50px;
            resize: none;
            border-radius: 6px;
            border: 1px solid #ccc;
            padding: 5px;
        }

        #send-btn {
            margin-top: 5px;
            width: 100%;
            padding: 8px;
            background-color: #3FBBC0;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        #chat-toggle {
            width: 60px;
            height: 60px;
            background-color: #3FBBC0;
            color: #fff;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            font-size: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
         <div id="chat-widget">
        <!-- Chat Box -->
        <div id="chat-box">
            <div class="header">
                Chat với trợ lý AI
                <button id="chat-close">&times;</button>
            </div>

            <div id="chat-messages">
                <div class="message ai-message">
                    Xin chào! Tôi là trợ lý của phòng khám. Tôi có thể giúp gì cho bạn?
                </div>

                <div id="chat-suggestions-inline">
                    <button class="suggestion-btn">Làm sao để đặt lịch khám?</button>
                    <button class="suggestion-btn">Phòng khám mở cửa lúc nào?</button>
                    <button class="suggestion-btn">Tôi có thể hủy lịch khám không?</button>
                </div>
            </div>

            <div style="padding: 10px; border-top: 1px solid #ccc; background-color: #fff;">
                <textarea id="chat-input" placeholder="Nhập câu hỏi của bạn..."></textarea>
                <button id="send-btn">Gửi</button>
            </div>
        </div>

        <!-- Nút mở chat -->
        <button id="chat-toggle">💬</button>
    </div>

    <!-- Script Chat -->
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const systemPrompt = `
Bạn là một trợ lý AI cho website ĐẶT LỊCH KHÁM BỆNH.
Bạn giúp người dùng trả lời các câu hỏi về đặt lịch khám, thông tin phòng khám, thời gian làm việc, và các dịch vụ y tế.
Bạn trả lời bằng tiếng Việt, lịch sự, dễ hiểu.
Nếu câu hỏi không liên quan đến chủ đề phòng khám, hãy trả lời: "Xin lỗi, tôi chỉ có thể hỗ trợ các thông tin liên quan đến đặt lịch khám và dịch vụ của phòng khám."
            `;
            const API_KEY = 'AIzaSyDYr78xklIHpNUY1F1LO3Vk3_Ujqn2SNrk';

            const chatToggleBtn = document.getElementById('chat-toggle');
            const chatCloseBtn = document.getElementById('chat-close');
            const chatBox = document.getElementById('chat-box');
            const sendBtn = document.getElementById('send-btn');
            const chatInput = document.getElementById('chat-input');
            const chatMessages = document.getElementById('chat-messages');

            // Toggle mở / đóng chat box
            chatToggleBtn.addEventListener('click', () => {
                chatBox.classList.toggle('open');
            });

            // Nút X đóng chat box
            chatCloseBtn.addEventListener('click', () => {
                chatBox.classList.remove('open');
            });

            // Gửi khi click Gửi
            sendBtn.addEventListener('click', sendMessage);

            // Gửi khi nhấn Enter
            chatInput.addEventListener('keydown', (event) => {
                if (event.key === 'Enter' && !event.shiftKey) {
                    event.preventDefault();
                    sendMessage();
                }
            });

            // Xử lý gợi ý → gửi luôn
            document.querySelectorAll('.suggestion-btn').forEach(button => {
                button.addEventListener('click', () => {
                    const question = button.textContent.trim();
                    chatInput.value = question;
                    sendMessage();
                });
            });

            // Hàm gửi message
            async function sendMessage() {
                const message = chatInput.value.trim();
                if (!message) return;
                addMessage(message, 'user');
                chatInput.value = '';
                addMessage('Đang soạn câu trả lời...', 'ai-loading');
                try {
                    const response = await fetch('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=' + API_KEY, {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            contents: [{
                                parts: [
                                    { text: systemPrompt },
                                    { text: message }
                                ]
                            }]
                        })
                    });
                    const data = await response.json();
                    const aiResponse = data?.candidates?.[0]?.content?.parts?.[0]?.text || 'Xin lỗi, tôi chưa có câu trả lời.';
                    removeLastAiLoading();
                    addMessage(aiResponse, 'ai');
                } catch (error) {
                    console.error('Error:', error);
                    removeLastAiLoading();
                    addMessage('Có lỗi xảy ra khi kết nối với AI.', 'ai');
                }
            }

            // Hàm add message
            function addMessage(message, sender) {
                const messageDiv = document.createElement('div');
                messageDiv.classList.add('message');
                if (sender === 'user') {
                    messageDiv.classList.add('user-message');
                } else if (sender === 'ai') {
                    messageDiv.classList.add('ai-message');
                } else if (sender === 'ai-loading') {
                    messageDiv.classList.add('ai-loading-message');
                }

                const formattedMessage = message
                    .replace(/\*/g, '')
                    .replace(/\n/g, '<br>')
                    .replace(/•/g, '&#8226;')
                    .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');

                messageDiv.innerHTML = formattedMessage;
                chatMessages.appendChild(messageDiv);
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }

            // Xóa "Đang soạn..."
            function removeLastAiLoading() {
                const lastMessage = chatMessages.lastElementChild;
                if (lastMessage && lastMessage.innerHTML.includes('Đang soạn câu trả lời...')) {
                    chatMessages.removeChild(lastMessage);
                }
            }
        });
    </script>
        
    </body>
</html>
