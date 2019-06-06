package cn.digitalpublishing.springmvc.form.product;

import cn.digitalpublishing.springmvc.form.BaseForm;

public class EpubForm extends BaseForm {

	private String id;
	//出版物ID
	private String works_id;
	//段落ID
	private String paragraph_id;
	//段落偏移
	private Integer paragraph_offset;
	//暂不明
	private Integer part_sequence;
	//暂不明
	private Integer part_paragraph_sequence;
	//前后文内容
	private String markContext;
	//笔记、划线参数内容 json格式
	private String annotation;
	//段落ID（逗号分隔的多个段落ID）
	private String paragraph_ids;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getWorks_id() {
		return works_id;
	}
	public void setWorks_id(String works_id) {
		this.works_id = works_id;
	}
	public String getParagraph_id() {
		return paragraph_id;
	}
	public void setParagraph_id(String paragraph_id) {
		this.paragraph_id = paragraph_id;
	}
	public Integer getParagraph_offset() {
		return paragraph_offset;
	}
	public void setParagraph_offset(Integer paragraph_offset) {
		this.paragraph_offset = paragraph_offset;
	}
	public Integer getPart_sequence() {
		return part_sequence;
	}
	public void setPart_sequence(Integer part_sequence) {
		this.part_sequence = part_sequence;
	}
	public Integer getPart_paragraph_sequence() {
		return part_paragraph_sequence;
	}
	public void setPart_paragraph_sequence(Integer part_paragraph_sequence) {
		this.part_paragraph_sequence = part_paragraph_sequence;
	}
	public String getMarkContext() {
		return markContext;
	}
	public void setMarkContext(String markContext) {
		this.markContext = markContext;
	}
	public String getAnnotation() {
		return annotation;
	}
	public void setAnnotation(String annotation) {
		this.annotation = annotation;
	}
	public String getParagraph_ids() {
		return paragraph_ids;
	}
	public void setParagraph_ids(String paragraph_ids) {
		this.paragraph_ids = paragraph_ids;
	}	
	
}
