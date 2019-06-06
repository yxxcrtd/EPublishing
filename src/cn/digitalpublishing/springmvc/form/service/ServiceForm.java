package cn.digitalpublishing.springmvc.form.service;

import cn.digitalpublishing.ep.po.BService;
import cn.digitalpublishing.springmvc.form.BaseForm;

public class ServiceForm extends BaseForm{

	private BService obj=new BService();
    private String serviceId;
	public BService getObj() {
		return obj;
	}

	public void setObj(BService obj) {
		this.obj = obj;
	}

	public String getServiceId() {
		return serviceId;
	}

	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
}
