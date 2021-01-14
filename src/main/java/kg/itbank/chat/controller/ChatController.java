package kg.itbank.chat.controller;

import lombok.RequiredArgsConstructor;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;

@Controller
@RequiredArgsConstructor
public class ChatController {

	
	private static final Logger log = LoggerFactory.getLogger(ChatController.class);

	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	
	
	@MessageMapping("/chat")
	public void sendMsg(String message) {
		
		System.out.println(message);		
		
		log.info("받은 메시지: {}", message);
		
		JSONObject jobj = new JSONObject(message);
		
		long chatRoomId = jobj.getLong("chatRoomId");
		String sender = jobj.getString("sender");
		String receiver = jobj.getString("receiver");
		String msg = jobj.getString("message");

		log.info("chatRoomId 메시지: {}", chatRoomId);
		log.info("sender 메시지: {}", sender);
		log.info("receiver 메시지: {}", receiver);
		log.info("msg 메시지: {}", msg);
		
		HashMap<String, Object> sendMsgMap = new HashMap<String, Object>();
		
		sendMsgMap.put("receiver", sender);
		sendMsgMap.put("message", msg);
		
		simpMessagingTemplate.convertAndSend("/topic/" + chatRoomId, sendMsgMap);
		
	}

}