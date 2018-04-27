package com.system.action;

import com.opensymphony.xwork2.ModelDriven;
import com.system.entity.*;
import com.system.enums.Constant;
import com.system.service.DoctorService;
import com.system.service.HospitalService;
import com.system.service.OfficeService;
import com.system.util.BeanUtil;
import com.system.util.StrUtil;
import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.List;

/**
 * Created by king on 2016/5/4.
 */
@Namespace("/doctors")
public class DoctorAction extends SuperAction implements ModelDriven<Doctor>{

    private Doctor doctorModel = new Doctor();

    private static final Logger LOGGER = Logger.getLogger(DoctorAction.class);

    @Autowired
    private HospitalService hospitalService;

    @Autowired
    private OfficeService officeService;

    @Autowired
    private DoctorService doctorService;


    @Action(value = "list",results = {
            @Result(name = "success",location = "../doctor_list.jsp"),
            @Result(name = "failure",location = "../errorMsg.jsp")
    })
    public String doctorList(){
        try{
            String pageNumString = request.getParameter("pageNum");
            int pageNum = 1;//设置默认页数
            if(StrUtil.isNum(pageNumString)){//如果是非法是字符串，则使用默认页数
                pageNum = Integer.parseInt(pageNumString);
            }
            Pager<Doctor> doctorPager = doctorService.findDoctor(doctorModel, pageNum, Constant.DEAULT_PAGE_SIZE);
            LOGGER.info(doctorPager);
            session.setAttribute("result",doctorPager);
            return "success";
        }catch (Exception e){
            LOGGER.error(e);
            session.setAttribute("errorMsg",new ErrorMsg(100,"系统内部异常"));
            return "failure";
        }
    }


    @Action(value = "info",results = {
            @Result(name = "success",location = "../doctor_info.jsp"),
            @Result(name = "failure",location = "../errorMsg.jsp")
    })
    public String doctorInfo(){
        try {
            String didString = request.getParameter("did");
            if(StrUtil.isNum(didString)){
                int did = Integer.parseInt(didString);
                Doctor doctor = doctorService.get(did);
                LOGGER.info(doctor);
                session.setAttribute("doctor",doctor);
                Office office = officeService.get(doctor.getOid());
                LOGGER.info(office);
                session.setAttribute("office",office);
                Hospital hospital = hospitalService.get(office.getHid());
                LOGGER.info(hospital);
                session.setAttribute("hospital",hospital);
                Date today = new Date(System.currentTimeMillis());
                session.setAttribute("today",today);//方便页面对时间的比较
                return "success";
            }else{
                session.setAttribute("errorMsg",new ErrorMsg(101,"非法的参数输入"));
                return "failure";
            }
        }catch (Exception e){
            LOGGER.error(e);
            session.setAttribute("errorMsg",new ErrorMsg(100,"系统内部异常"));
            return "failure";
        }
    }

    /**
     * 医生登录
     * @return
     */
    @Action(value = "login",results = {
            @Result(name = "success",location = "/chat/chatroom" ,type = "redirect"),
            @Result(name = "failure",location = "/home/welcomeAdmin",type = "redirect")
    })
    public String login(){
        try {
            List<Doctor> tmp = doctorService.findByName(doctorModel.getName());
            int size = tmp.size();
			if (size > 0){
				LOGGER.info("医生登录成功");
				session.setAttribute("doctorname", tmp.get(0).getName());
				return "success";
            }else{
                LOGGER.warn("该管理员不存在");
                session.setAttribute("errorMsg",new ErrorMsg(112,"该管理员不存在"));
                return "failure";
            }
        }catch (Exception e){
            LOGGER.error(e);
            session.setAttribute("errorMsg",new ErrorMsg(100,"系统内部异常"));
            return "failure";
        }
    }
    
    public Doctor getModel() {
        return doctorModel;
    }
}
