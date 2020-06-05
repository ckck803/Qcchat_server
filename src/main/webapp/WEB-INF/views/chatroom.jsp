<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>QCCHAT</title>
<link rel="icon" href="static/img/chat.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="static/css/chatroom.css">
<link rel="stylesheet" type="text/css" href="static/css/common/layui.css">
<link rel="stylesheet" type="text/css" href="static/css/common/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="static/css/common/fileinput.min.css">
</head>
<body>
<div class="qqBox">
    <div class="BoxHead">
        <div class="headImg">
            <img id="avatarUrl" src=""/>
        </div>
        <div id="username" class="internetName"></div>
        <button class="close logout" onclick="logout()">&times;</button>
    </div>
    <div class="context">
        <div class="conLeft">
            <ul>
                
            </ul>
        </div>
        <div class="conRight">
            <div class="Righthead">
                <div class="headName"></div>
            </div>
            <div class="RightCont">
                <ul class="newsList-temp"></ul>
                <ul class="newsList">
                
                </ul>
            </div>
            <div class="RightFoot">
                <div class="emjon">
                    <ul>
                        <li><img src="static/img/emoji/emoji_01.png"></li>
                        <li><img src="static/img/emoji/emoji_02.png"></li>
                        <li><img src="static/img/emoji/emoji_03.png"></li>
                        <li><img src="static/img/emoji/emoji_04.png"></li>
                        <li><img src="static/img/emoji/emoji_05.png"></li>
                        <li><img src="static/img/emoji/emoji_06.png"></li>
                        <li><img src="static/img/emoji/emoji_07.png"></li>
                        <li><img src="static/img/emoji/emoji_08.png"></li>
                        <li><img src="static/img/emoji/emoji_09.png"></li>
                        <li><img src="static/img/emoji/emoji_10.png"></li>
                        <li><img src="static/img/emoji/emoji_11.png"></li>
                        <li><img src="static/img/emoji/emoji_12.png"></li>
                        <li><img src="static/img/emoji/emoji_13.png"></li>
                        <li><img src="static/img/emoji/emoji_14.png"></li>
                        <li><img src="static/img/emoji/emoji_15.png"></li>
                        <li><img src="static/img/emoji/emoji_16.png"></li>
                        <li><img src="static/img/emoji/emoji_17.png"></li>
                        <li><img src="static/img/emoji/emoji_18.png"></li>
                        <li><img src="static/img/emoji/emoji_19.png"></li>
                        <li><img src="static/img/emoji/emoji_20.png"></li>
                        <li><img src="static/img/emoji/emoji_21.png"></li>
                        <li><img src="static/img/emoji/emoji_22.png"></li>
                        <li><img src="static/img/emoji/emoji_23.png"></li>
                        <li><img src="static/img/emoji/emoji_24.png"></li>
                    </ul>
                </div>
                <div class="footTop">
                    <ul>
                        <li class="ExP">
                            <img src="static/img/emoji.jpg">
                        </li>
                        <li class="file-upload">
                            <a data-toggle="modal" data-target="#upload-modal" data-backdrop="static">
                                <img  src="static/img/upload.jpg">
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="inputBox">
                    <input id="toUserId" type="hidden">
                    <input id="toGroupId" type="hidden">
                    <textarea id="dope" style="width: 99%;height: 75px; border: none;outline: none;" name="" rows="" cols=""></textarea>
                    <button title="enter" class="sendBtn">send</button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="upload-modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h3 class="modal-title text-primary">upload</h3>
                </div>
                <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">select file</label>
                        <div class="col-sm-9">
                            <input type="file" name="file"
                                class="col-sm-9 myfile" />
                            <p class="help-block">참고 : 파일 크기는 30M을 초과하지 않으며 유효 기간은 7 일입니다.</p>
                        </div>
                    </div>
                </form>
                </div>
                <div class="modal-footer">
                        <button id="upload-cancel" class="btn btn-sm btn-muted" data-dismiss="modal">
                        <i class="glyphicon glyphicon-remove"></i> cancel
                    </button>
                </div>
            </div>
        </div>
    </div>
    
</div>


<script type="text/javascript" src="static/js/common/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="static/js/common/jquery.actual.min.js"></script>
<script type="text/javascript" src="static/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="static/js/common/fileinput.min.js"></script>
<script type="text/javascript" src="static/js/common/zh.js"></script>
<script type="text/javascript" src="static/js/chatroom.js"></script>
<script type="text/javascript">
    var userId;
    var socket;   
    var sentMessageMap;
    
    setSentMessageMap();

    if(!window.WebSocket){  
        window.WebSocket = window.MozWebSocket;  
    }  
    if(window.WebSocket){  
        socket = new WebSocket("ws://localhost:3333");  
        socket.onmessage = function(event){  
            var json = JSON.parse(event.data);    
            if (json.status == 200) {
                var type = json.data.type;
                console.log("new message：" + type);
                switch(type) {
                    case "REGISTER":
                        ws.registerReceive();
                        break;
                    case "SINGLE_SENDING":
                        ws.singleReceive(json.data);
                        break;
                    case "GROUP_SENDING":   
                        ws.groupReceive(json.data);
                        break;
                    case "FILE_MSG_SINGLE_SENDING":
                        ws.fileMsgSingleRecieve(json.data);
                        break;
                    case "FILE_MSG_GROUP_SENDING":
                        ws.fileMsgGroupRecieve(json.data);
                        break;
                    default:
                        console.log("wrong types!");
                }
            } else {
                alert(json.msg);
                console.log(json.msg);
            }
        };  
     
        
        socket.onopen = setTimeout(function(event){ 
              console.log("WebSocket connect！");  
              ws.register();
        }, 1000)  
     
        socket.onclose = function(event){  
              console.log("WebSocket closed...");  
        };  
    } else {  
          alert("wrong browse！");  
    }
    
</script>


</body>
</html>