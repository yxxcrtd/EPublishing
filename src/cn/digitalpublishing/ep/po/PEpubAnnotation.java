package cn.digitalpublishing.ep.po;

import java.util.Date;
/**
 * 笔记、划线
 * @author jack
 *
 */
public class PEpubAnnotation {
	private String id;
	//类型 underline 划线   note 笔记
	private String type;
	//笔记
	private String note;
	//中间的部分段落的ID
	private String middleContainers;
	//起始段落ID
	private String startContainerId;
	//结束段落ID
	private String endContainerId;
	//起始段落偏移
	private Integer startOffset;
	//结束段落偏移
	private Integer endOffset;
	//是否仅自己可见
	private String visiblePrivate;
	//所属出版物
	private PPublications publications;
	//书签所属用户
	private CUser user;
	//创建时间
	private Date createOn;
	//添加笔记、划线时选中的文本内容
	private String text;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getMiddleContainers() {
		return middleContainers;
	}
	public void setMiddleContainers(String middleContainers) {
		this.middleContainers = middleContainers;
	}
	public String getStartContainerId() {
		return startContainerId;
	}
	public void setStartContainerId(String startContainerId) {
		this.startContainerId = startContainerId;
	}
	public String getEndContainerId() {
		return endContainerId;
	}
	public void setEndContainerId(String endContainerId) {
		this.endContainerId = endContainerId;
	}
	public Integer getStartOffset() {
		return startOffset;
	}
	public void setStartOffset(Integer startOffset) {
		this.startOffset = startOffset;
	}
	public Integer getEndOffset() {
		return endOffset;
	}
	public void setEndOffset(Integer endOffset) {
		this.endOffset = endOffset;
	}
	public String getVisiblePrivate() {
		return visiblePrivate;
	}
	public void setVisiblePrivate(String visiblePrivate) {
		this.visiblePrivate = visiblePrivate;
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
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	
}
