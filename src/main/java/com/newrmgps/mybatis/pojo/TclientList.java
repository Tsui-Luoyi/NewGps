package com.newrmgps.mybatis.pojo;

public class TclientList extends Tclient {
	//不和数据库的字段一致.
    private  String  user_name;
    private  Integer   days;
	public Integer getDays() {
		return days;
	}

	@Override
	public String toString() {
		return "TclientList [user_name=" + user_name + ", days=" + days
				+ ", getDays()=" + getDays() + ", getUser_name()="
				+ getUser_name() + ", toString()=" + super.toString()
				+ ", getId()=" + getId() + ", getCreatetime()="
				+ getCreatetime() + ", getClientname()=" + getClientname()
				+ ", getCreaterUserid()=" + getCreaterUserid()
				+ ", getContactName()=" + getContactName()
				+ ", getContactPhone()=" + getContactPhone() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + "]";
	}

	public void setDays(Integer days) {
		this.days = days;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}




}
