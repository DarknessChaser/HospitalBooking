package com.system.dao;

import com.system.entity.UserInfo;

/**
 * Created by king on 2018/4/21.
 */
public interface UserInfoDao extends GenericDao<UserInfo,Integer> {

    UserInfo findByPhone(String phone);
}
