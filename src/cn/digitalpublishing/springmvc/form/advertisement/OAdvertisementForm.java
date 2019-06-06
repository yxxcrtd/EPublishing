package cn.digitalpublishing.springmvc.form.advertisement;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import cn.digitalpublishing.ep.po.OAdvertisement;
import cn.digitalpublishing.springmvc.form.BaseForm;

/**
 * 广告
 * 
 * @author LiuYe
 * 
 */
public class OAdvertisementForm extends BaseForm {

	private OAdvertisement obj = new OAdvertisement();
	private CommonsMultipartFile file = null;
	private String startTime;
	private String endTime;
	private Integer position;
	private Integer status;

	public OAdvertisement getObj() {
		return obj;
	}

	public void setObj(OAdvertisement obj) {
		this.obj = obj;
	}

	public CommonsMultipartFile getFile() {
		return file;
	}

	public void setFile(CommonsMultipartFile file) {
		this.file = file;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Integer getPosition() {
		return position;
	}

	public void setPosition(Integer position) {
		this.position = position;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
}
