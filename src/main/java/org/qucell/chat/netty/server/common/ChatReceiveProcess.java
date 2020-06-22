package org.qucell.chat.netty.server.common;

import org.qucell.chat.model.JsonMsgRes;
import org.qucell.chat.model.room.Room;
import org.qucell.chat.netty.server.common.client.Client;
import org.qucell.chat.netty.server.common.client.ClientAdapter;
import org.qucell.chat.netty.server.repo.ClientIdFriendIdRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

/**
 * updated 20/06/17
 * @author myseo
 */
@Slf4j
@Component
@Qualifier("chatReceiveProcess")
public class ChatReceiveProcess {
	
//	private ChatReceiveProcess() {}
//	//singleton
//	public static final ChatReceiveProcess INSTANCE = new ChatReceiveProcess();
	
	@Autowired 
	private ClientIdFriendIdRepository clientIdFriendIdRepository;
	
	public void process(Client client, JsonMsgRes entity) {
		EventType eventType = EventType.from(entity);
		ClientAdapter adapter = ClientAdapter.INSTANCE;
		String roomId = entity.extractFromHeader("roomId");
		
		switch(eventType) {
		case LogIn:
			adapter.login(client);
			adapter.sendAllClientListToClient(client);
			adapter.sendAllRoomListToClient(client);
			clientIdFriendIdRepository.writeAndFlush(client);
			break;
		case LogOut:
			adapter.logout(client);
			break;
		case FriendsList:
			clientIdFriendIdRepository.writeAndFlush(client);
			break;
		case AllUserList:
			//현재 접속해있는 모든 클라이언트 목록을 조회할 수 있다.
			adapter.sendAllClientListToClient(client);
			break;
		case CreateRoom:
			adapter.createRoom(client, roomId);
			break;
		case EnterToRoom:
			adapter.enterRoom(client, roomId);
			break;
		case ExitFromRoom:
			adapter.exitRoom(client, roomId);
			break;
		case SendMsg:
			Room room = adapter.getRoomByRoomId(roomId);
			room.sendMsg(client, entity.msg);
			break;
		}
	}
}
