package com.system.chat;

import java.io.IOException;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/websocket/{loginName}")
public class Server {// 自定义一个服务端 名字随便
	private Session session;

	/**
	 * 开始连接websocket
	 * 
	 * @param session
	 * @param loginName
	 *            当前登录账号
	 */
	@OnOpen
	public void open(Session session, @PathParam("loginName") String loginName) {
		this.session = session;
		Users.user.put(loginName, this);// 保存当前的对象，用于发送或接收消息
	}

	/**
	 * 发送消息
	 * 
	 * @param message
	 *            发送消息
	 * @throws IOException
	 */
	@OnMessage
	public void message(String message) throws IOException {
		// 发送给全部人
		for (Server server : Users.user.values()) {
			// 全部发送消息
			server.session.getBasicRemote().sendText(message);
		}
		/*
		 * 如果是一对一发送消息的话 Users.user中只获取发消息和接收消息的对象 不用获取全部 比如：光头强 发给 熊大
		 * Users.user.get("光头强").session.getBasicRemote().sendText(message);
		 * Users.user.get("熊大").session.getBasicRemote().sendText(message);
		 */
	}

	/**
	 * 关闭
	 * 
	 * @param session
	 */
	@OnClose
	public void close(Session session) {
		System.out.println("Close");
	}

	/**
	 * 出错
	 * 
	 * @param t
	 * @param session
	 */
	@OnError
	public void error(Throwable t, Session session) {
		System.out.println(t.getMessage());
		System.out.println("Error");
	}
}
