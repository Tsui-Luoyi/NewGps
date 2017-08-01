package com.newrmgps.mybatis.pojo;

import java.util.Date;

public class Tuser {
    @Override
	public String toString() {
		return "Tuser [id=" + id + ", userCode=" + userCode + ", userName="
				+ userName + ", userSex=" + userSex + ", userTypeid="
				+ userTypeid + ", userStatus=" + userStatus + ", userPassword="
				+ userPassword + ", createtime=" + createtime
				+ ", createrUserid=" + createrUserid + ", clientid=" + clientid
				+ ", del=" + del + "]";
	}

	private Integer id;

    private String userCode;

    private String userName;

    private Boolean userSex;

    private String userTypeid;

    private Boolean userStatus;

    private String userPassword;

    private Date createtime;

    private Integer createrUserid;

    private Integer clientid;

    private Boolean del;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode == null ? null : userCode.trim();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public Boolean getUserSex() {
        return userSex;
    }

    public void setUserSex(Boolean userSex) {
        this.userSex = userSex;
    }

    public String getUserTypeid() {
        return userTypeid;
    }

    public void setUserTypeid(String userTypeid) {
        this.userTypeid = userTypeid == null ? null : userTypeid.trim();
    }

    public Boolean getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Boolean userStatus) {
        this.userStatus = userStatus;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword == null ? null : userPassword.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Integer getCreaterUserid() {
        return createrUserid;
    }

    public void setCreaterUserid(Integer createrUserid) {
        this.createrUserid = createrUserid;
    }

    public Integer getClientid() {
        return clientid;
    }

    public void setClientid(Integer clientid) {
        this.clientid = clientid;
    }

    public Boolean getDel() {
        return del;
    }

    public void setDel(Boolean del) {
        this.del = del;
    }
}