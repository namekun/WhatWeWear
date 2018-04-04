package wear.we.what.chatbot;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ibm.watson.developer_cloud.conversation.v1.Conversation;
import com.ibm.watson.developer_cloud.conversation.v1.model.Context;
import com.ibm.watson.developer_cloud.conversation.v1.model.InputData;
import com.ibm.watson.developer_cloud.conversation.v1.model.MessageOptions;
import com.ibm.watson.developer_cloud.conversation.v1.model.MessageResponse;
import com.ibm.watson.developer_cloud.conversation.v1.model.OutputData;

@RestController // json 형태의 데이터를 받아서 view를 거치지 않고 출력

@RequestMapping("chatbot") // mapping 통일

public class WatsonSay extends savingsParser {
	private static final Logger logger = LoggerFactory.getLogger(WatsonSay.class);

	@RequestMapping("watsonsay") // chatbot/watsonsay 로 매핑
	
	// 왓슨에서 전달해주는 MessageResponse 값을 그대로 리턴
	
	// 사용자가 입력한 값을 isay 파라미터로 받는다.
	
	// 파라미터로 session 정보를 받아온다.(노드를 계속 타서 대화의 흐름을 유지시키기 위함)
	
	public MessageResponse watsonsay(String isay, HttpSession session) throws Exception {
		logger.info("user input : " + isay);

		String weather = null;
		String temp = null;

		
		// watson conversation service &id &pw
		Conversation service = new Conversation(Conversation.VERSION_DATE_2017_05_26);
		service.setUsernameAndPassword("id", "pw");


		// .Builder에는 WorkspaceID를 넣는다.
		MessageOptions options =  new MessageOptions.Builder("workspaceID")
				.input(new InputData.Builder(isay).build()).context((Context) session.getAttribute("context")).build(); 
			// 세션에서 값을 꺼내서 컨텍스트에 넣는다.(대화흐름 세션유지))
				

		if (!isay.equals("")) { // isay가 공백이 아닐 때(대화를 유지)
				
			options =  new MessageOptions.Builder("workspaceID")
					.input(new InputData.Builder(isay).build()).context((Context) session.getAttribute("context"))
					.build();

		} else { // isay가 공백일 때(대화를 재시작)
			options =  new MessageOptions.Builder("workspaceID")
					.input(new InputData.Builder(isay).build()).build();
		}

	
		
		
		MessageResponse response = service.message(options).execute(); // 메세지 응답을 받아서 service.message로 실행한다.
		
		session.setAttribute("context", response.getContext()); // context 정보를 세션에 넣어 대화흐름을 유지시킨다.(노드 연결)
		
		String watsonsay = response.getOutput().getText().get(0);// 실행한걸 리스폰스 타입으로 받는다.
		
		session.invalidate();//context초기화(대화의 흐름을 다시 초기화!)
		
		if (response.getContext().get("weather") != null && response.getIntents().get(0).getIntent().equals("날씨")) { 
			//context값이 weather이고, intent값이 날씨 일때만!
			
			savingsParser sp = new savingsParser();
			
			weather = sp.apiParserSearch(); // weather에 return되는 값을 집어 넣습니다.

			OutputData op = new OutputData(); // output 인스턴스 선언

			List<String> list = new ArrayList<String>();
			list.add(weather);
	
			op.setText(list); // 리스트에서 text를 가져와서 op에 넣는다.

			response.setOutput(op);// 리스폰스의 아웃풋을 op로.

			logger.info(watsonsay, response.getOutput());
			
			return response;
			
			

		} else if(response.getContext().get("recommend") != null && response.getIntents().get(0).getIntent().equals("옷추천")){	
			//context값이 recommend이고, intent값이 옷추천 일때만!
			
			savingsParser sp = new savingsParser();
			temp = sp.apiParserTempSearch();
			
			//int int_temp = Integer.parseInt(temp);
			
			OutputData op = new OutputData(); // output 인스턴스 선언

			List<String> list = new ArrayList<String>();
			list.add(temp);
			
			op.setText(list); // 리스트에서 text를 가져와서 op에 넣는다.

			response.setOutput(op);// 리스폰스의 아웃풋을 op로.

			logger.info(watsonsay, response.getOutput());
			
			return response;
		
		}
		else {
			logger.info(response.toString()); // json 형태로 결과가 나온다.
			
			logger.info(watsonsay, response.getOutput());
			
			return response;		
		}
		
	
	}

}