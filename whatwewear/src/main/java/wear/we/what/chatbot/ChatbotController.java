package wear.we.what.chatbot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("chatbot")	//�� ó���� ȭ�� ���� ���� mapping
public class ChatbotController {
	
	@RequestMapping("/")	// "/"�� ����
	public String init() {
		return "chatbot";	//url�� chatbot/ �϶� chatbot.jsp�� �̵�
	}
	
}
