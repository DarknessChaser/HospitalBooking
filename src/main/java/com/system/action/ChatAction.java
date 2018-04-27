package com.system.action;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;

import com.system.action.SuperAction;

/**
 *
 * 系统访问首页
 * Created by king on 2016/5/25.
 */
@Namespace("/chat")
public class ChatAction extends SuperAction {

    @Action(value = "chatroom" ,results = {
            @Result(name = "success",location = "../chatroom.jsp")
    })
    public String chatroom(){
    	String doctorname = (String) session.getAttribute("doctorname");
    	if (StringUtils.isNotBlank(doctorname)) {
    		session.setAttribute("chatname",doctorname+"医生");
		} else {
			String userPhone = request.getParameter("userPhone");
			if (StringUtils.isNotBlank(userPhone)) {
				session.setAttribute("chatname",userPhone);
			} else {
				session.setAttribute("chatname","患者"+((Math.random()*9+1)*1000));
			}
		}
        return "success";
    }
}
