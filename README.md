# Qcchat_server - Junior Developer Seminar project 
## spec
- framework
  - netty
  - redis
  - mybatis
  - spring
- module
  - login
  - jwt token authorization
  - redis cache
  - chatroom 
  
## in progress

- todo
  - modify chat room password
  - 방을 생성할 때 친구 리스트를 선택해서 만들기 
  - 이미지 업로드 
  - 사용자 프로필 변경하기 
  - nginx를 사용해서 사용자 채팅 로그 남기기(redis mapping)
  
## complete
- login + jwt token authorization 
- get friends list 
- get room list (user attending/ not attending)
- create new chat room
- add user in chat room 
- get user list in chat room 
- send message in chat room 
- get message log by room name
- get room list by user id (user logout -> login)
- chat process (netty, redis - cache database, websocket)
    - multi chat
    - single chat
- ui 

## Change
- 채팅방 방장 제도 없앰 (사람이 한 명도 남아있지 않으면 채팅방 자동 제거)
- jwt 토큰은 처음 사용자가 로그인을 하고 웹 소켓을 연결할 때 인증 용도로 사용 (웹 소켓 통신을 할 때 주고받지 않음)
