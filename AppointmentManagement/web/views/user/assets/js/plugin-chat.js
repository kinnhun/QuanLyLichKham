// Tạo khung chat nếu chưa có
if (!document.getElementById('chat-widget')) {
const chatWidgetHTML = `
    <div id="chat-widget" style="position: fixed; bottom: 20px; right: 20px; z-index: 9999; display: flex; flex-direction: column; align-items: flex-end;">

        <!-- Khung chat -->
        <div id="chat-box" style="
            display: none;
            width: 320px;
            height: 450px;
            background: #fff;
            border: 1px solid #ccc;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            margin-bottom: 10px;
            transition: all 0.3s ease;
    
        ">

            <!-- Header -->
            <div style="
                background-color: #3FBBC0;
                color: white;
                padding: 10px;
                text-align: center;
                font-weight: bold;
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
            ">Chat với AI</div>

            <!-- Messages -->
            <div id="chat-messages" style="
                flex: 1;
                padding: 10px;
                overflow-y: auto;
                background-color: #f9f9f9;
            "></div>

            <!-- Input -->
            <div style="
                padding: 10px;
                border-top: 1px solid #ccc;
                background-color: #fff;
            ">
                <textarea id="chat-input" placeholder="Nhập nội dung..." style="
                    width: 100%;
                    height: 50px;
                    resize: none;
                    border-radius: 6px;
                    border: 1px solid #ccc;
                    padding: 5px;
                "></textarea>
                <button id="send-btn" style="
                    margin-top: 5px;
                    width: 100%;
                    padding: 8px;
                    background-color: #3FBBC0;
                    color: #fff;
                    border: none;
                    border-radius: 6px;
                    font-weight: bold;
                    cursor: pointer;
                ">Gửi</button>
            </div>

        </div>

        <!-- Nút Chat tròn -->
        <button id="chat-toggle" style="
            width: 60px; height: 60px;
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
        ">💬</button>

    </div>
    `;
        document.body.insertAdjacentHTML('beforeend', chatWidgetHTML);
}



const systemPrompt = `
Bạn là một trợ lý AI cho website ĐẶT LỊCH KHÁM BỆNH.
Bạn giúp người dùng trả lời các câu hỏi về đặt lịch khám, thông tin phòng khám, thời gian làm việc, và các dịch vụ y tế.
Bạn trả lời bằng tiếng Việt, lịch sự, dễ hiểu.
Nếu câu hỏi không liên quan đến chủ đề phòng khám, hãy trả lời: "Xin lỗi, tôi chỉ có thể hỗ trợ các thông tin liên quan đến đặt lịch khám và dịch vụ của phòng khám."
`;
// Cấu hình API_KEY
        const API_KEY = 'AIzaSyDYr78xklIHpNUY1F1LO3Vk3_Ujqn2SNrk';
// Toggle hiển thị chat box
        document.getElementById('chat-toggle').addEventListener('click', function() {
const chatBox = document.getElementById('chat-box');
        chatBox.style.display = (chatBox.style.display === 'none') ? 'flex' : 'none';
});
// Gửi tin nhắn
        document.getElementById('send-btn').addEventListener('click', async function() {
const inputField = document.getElementById('chat-input');
        const message = inputField.value.trim();
        if (!message) return;
        addMessage(message, 'user');
        inputField.value = '';
        // Hiện "AI đang soạn..."
        addMessage('Đang soạn câu trả lời...', 'ai-loading');
        try {
        const response = await fetch('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=' + API_KEY, {
        method: 'POST',
                headers: {
                'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                contents: [{
                parts: [
                { text: systemPrompt }, // Prompt dẫn hướng trước
                { text: message }        // Sau đó là message user nhập
                ]
                }]
                })
        });
                const data = await response.json();
                const aiResponse = data?.candidates?.[0]?.content?.parts?.[0]?.text || 'Xin lỗi, tôi chưa có câu trả lời.';
                // Xóa "Đang soạn..."
                removeLastAiLoading();
                addMessage(aiResponse, 'ai');
        } catch (error) {
console.error('Error:', error);
        removeLastAiLoading();
        addMessage('Có lỗi xảy ra khi kết nối với AI.', 'ai');
        }
});
// Hàm hiển thị tin nhắn
    function addMessage(message, sender) {
    const chatMessages = document.getElementById('chat-messages');
    const messageDiv = document.createElement('div');
    messageDiv.classList.add('message', `${sender}-message`);

    // Xử lý định dạng văn bản
    const formattedMessage = message
        .replace(/\*/g, '') // Xóa * đơn
        .replace(/\n/g, '<br>') // Xuống dòng
        .replace(/•/g, '&#8226;') // Chuyển dấu đầu dòng
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>'); // Bôi đậm **text**

    // Style theo người gửi
    messageDiv.style.marginBottom = '8px';
    messageDiv.style.padding = '8px 12px';
    messageDiv.style.borderRadius = '12px';
    messageDiv.style.maxWidth = '80%';
    messageDiv.style.wordWrap = 'break-word';
    messageDiv.style.clear = 'both';

    if (sender === 'user') {
        messageDiv.style.backgroundColor = '#DCF8C6';
        messageDiv.style.alignSelf = 'flex-end';
        messageDiv.style.marginLeft = 'auto';
        messageDiv.style.textAlign = 'right';
    } else if (sender === 'ai') {
        messageDiv.style.backgroundColor = '#F1F0F0';
        messageDiv.style.alignSelf = 'flex-start';
        messageDiv.style.marginRight = 'auto';
        messageDiv.style.textAlign = 'left';
    } else if (sender === 'ai-loading') {
        messageDiv.style.backgroundColor = '#eee';
        messageDiv.style.alignSelf = 'flex-start';
        messageDiv.style.marginRight = 'auto';
        messageDiv.style.textAlign = 'left';
        messageDiv.style.fontStyle = 'italic';
    }

    messageDiv.innerHTML = formattedMessage;
    chatMessages.appendChild(messageDiv);
    chatMessages.scrollTop = chatMessages.scrollHeight;
}


// Xóa "AI đang soạn..."
function removeLastAiLoading() {
const chatMessages = document.getElementById('chat-messages');
        const lastMessage = chatMessages.lastElementChild;
        if (lastMessage && lastMessage.innerHTML.includes('Đang soạn câu trả lời...')) {
chatMessages.removeChild(lastMessage);
        }
}
