package com.newrmgps.mybatis.pojo;

import java.util.Date;

public class Tclient {
	/*26号添加test*/
    @Override
	public String toString() {
		return "Tclient [id=" + id + ", createtime=" + createtime
				+ ", clientname=" + clientname + ", createrUserid="
				+ createrUserid + ", contactName=" + contactName
				+ ", contactPhone=" + contactPhone + "]";
	}

	private Integer id;

    private Date createtime;

    private String clientname;

    private Integer createrUserid;

    private String contactName;

    private String contactPhone;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getClientname() {
        return clientname;
    }

    public void setClientname(String clientname) {
        this.clientname = clientname == null ? null : clientname.trim();
    }

    public Integer getCreaterUserid() {
        return createrUserid;
    }

    public void setCreaterUserid(Integer createrUserid) {
        this.createrUserid = createrUserid;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName == null ? null : contactName.trim();
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone == null ? null : contactPhone.trim();
    }
}