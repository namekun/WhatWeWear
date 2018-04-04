package wear.we.what.chatbot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("chatbot")	//맨 처음에 화면 띄우기 위한 mapping
public class ChatbotController {
	
	@RequestMapping("/")	// "/"에 매핑
	public String init() {
		return "chatbot";	//url이 chatbot/ 일때 chatbot.jsp로 이동
	}
	
}
