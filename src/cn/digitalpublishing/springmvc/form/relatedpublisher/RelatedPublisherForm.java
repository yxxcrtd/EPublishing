package cn.digitalpublishing.springmvc.form.relatedpublisher;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import cn.digitalpublishing.ep.po.PRelatedPublisher;
import cn.digitalpublishing.springmvc.form.BaseForm;

public class RelatedPublisherForm extends BaseForm{

	private PRelatedPublisher obj;
	private CommonsMultipartFile picPath = null;
	private Integer position;
	public PRelatedPublisher getObj() {
		return obj;
	}

	public void setObj(PRelatedPublisher obj) {
		this.obj = obj;
	}

	public CommonsMultipartFile getPicPath() {
		return picPath;
	}

	public void setPicPath(CommonsMultipartFile picPath) {
		this.picPath = picPath;
	}

	public Integer getPosition() {
		return position;
	}

	public void setPosition(Integer position) {
		this.position = position;
	}
	
}
