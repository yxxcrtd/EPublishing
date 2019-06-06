package cn.digitalpublishing.ep.po;

import java.util.Date;

public class PEpubBookmark {
	private String id;
	//段落ID
	private String paragraphId;
	//段落偏移
	private Integer paragraphOffset;
	private Integer partSequence;
	private Integer partParagraphSequence;
	//前后文内容
	private String markContext;
	//书签所属出版物
	private PPublications publications;
	//书签所属用户
	private CUser user;
	
	private Date createOn;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getParagraphId() {
		return paragraphId;
	}
	public void setParagraphId(String paragraphId) {
		this.paragraphId = paragraphId;
	}
	public Integer getParagraphOffset() {
		return paragraphOffset;
	}
	public void setParagraphOffset(Integer paragraphOffset) {
		this.paragraphOffset = paragraphOffset;
	}
	
	public Integer getPartSequence() {
		return partSequence;
	}
	public void setPartSequence(Integer partSequence) {
		this.partSequence = partSequence;
	}
	public Integer getPartParagraphSequence() {
		return partParagraphSequence;
	}
	public void setPartParagraphSequence(Integer partParagraphSequence) {
		this.partParagraphSequence = partParagraphSequence;
	}
	public PPublications getPublications() {
		return publications;
	}
	public void setPublications(PPublications publications) {
		this.publications = publications;
	}
	public CUser getUser() {
		return user;
	}
	public void setUser(CUser user) {
		this.user = user;
	}
	public Date getCreateOn() {
		return createOn;
	}
	public void setCreateOn(Date createOn) {
		this.createOn = createOn;
	}
	public String getMarkContext() {
		return markContext;
	}
	public void setMarkContext(String markContext) {
		this.markContext = markContext;
	}
	
	
}
