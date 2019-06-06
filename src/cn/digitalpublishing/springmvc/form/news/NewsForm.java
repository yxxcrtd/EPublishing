package cn.digitalpublishing.springmvc.form.news;

import cn.digitalpublishing.ep.po.PNews;
import cn.digitalpublishing.springmvc.form.BaseForm;

public class NewsForm extends BaseForm{

	private PNews obj;

	private String createDate;
	
	private String content;
	
	private String newsId;
	public PNews getObj() {
		return obj;
	}

	public void setObj(PNews obj) {
		this.obj = obj;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getNewsId() {
		return newsId;
	}

	public void setNewsId(String newsId) {
		this.newsId = newsId;
	}
	
}
