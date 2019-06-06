package cn.digitalpublishing.ep.po;

import java.io.Serializable;

@SuppressWarnings("serial")
public class EBSource implements Serializable{
	/**
	 * 主键
	 */
	private String id;
	/**
	 * 代码
	 */
	private String code;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 1.出版商 2.代理商
	 */
	private Integer type;
	/**
	 * 相关出版社
	 */
	private String publisher;	
	
	private String userId;
	/**
	 * 是否海外 1-是 2-否
	 */
	private Integer overseas;
	
	
	
	//以下三项用于记录按来源统计敏感词筛查的数据
	private Integer unPassed;
	private Integer passed;
	private Integer unCheck;
	//-------------------------------------------------------
	
	/**
	 * 1-未发送 2-已发送 null-未发送
	 */
	private Integer sendStatus;
	/**
	 * 1-未免审 2-免审
	 * 
	 */
    private Integer trial;
    /**
     * EPUB文件分段表达式（css选择器）
     */
    private String epubSegExp;
    
    
    /*********************DRM 设置 start******************************/
    private Integer probationStatus;//标识允许试读的提供商 1-允许 2-不允许
    
	private String probationPer;//试读百分比值
	
	private String probationValue;//试读绝对值
	
	private Integer continuousPrint;//连续打印 0-默认值 1-允许连续打印 2-不允许连续打印 
	
	/**
	 * 期刊拷贝百分比
	 */
	private String journalBrowse;
	/**
	 * 期刊打印百分比
	 */
	private String journalPrint;
	/**
	 * 期刊下载百分比
	 */
	private String  journalDownload;
/**
	 * 浏览百分比
	 */
	private String browsePrecent;
	/**
	 * 下载百分比
	 */
	private String downloadPercent;
	/**
	 * 打印百分比
	 */
	private String printPercent;

	/*********************DRM 设置 end******************************/
	
	public String getId() {
		return id;
	}

	public String getJournalBrowse() {
		return journalBrowse;
	}

	public void setJournalBrowse(String journalBrowse) {
		this.journalBrowse = journalBrowse;
	}

	public String getJournalPrint() {
		return journalPrint;
	}

	public void setJournalPrint(String journalPrint) {
		this.journalPrint = journalPrint;
	}

	public String getJournalDownload() {
		return journalDownload;
	}

	public void setJournalDownload(String journalDownload) {
		this.journalDownload = journalDownload;
	}

	public String getBrowsePrecent() {
		return browsePrecent;
	}

	public void setBrowsePrecent(String browsePrecent) {
		this.browsePrecent = browsePrecent;
	}

	public String getDownloadPercent() {
		return downloadPercent;
	}

	public void setDownloadPercent(String downloadPercent) {
		this.downloadPercent = downloadPercent;
	}

	public String getPrintPercent() {
		return printPercent;
	}

	public void setPrintPercent(String printPercent) {
		this.printPercent = printPercent;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Integer getOverseas() {
		return overseas;
	}

	public void setOverseas(Integer overseas) {
		this.overseas = overseas;
	}

	

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public Integer getUnPassed() {
		return unPassed;
	}

	public void setUnPassed(Integer unPassed) {
		this.unPassed = unPassed;
	}

	public Integer getPassed() {
		return passed;
	}

	public void setPassed(Integer passed) {
		this.passed = passed;
	}

	public Integer getUnCheck() {
		return unCheck;
	}

	public void setUnCheck(Integer unCheck) {
		this.unCheck = unCheck;
	}

	public Integer getSendStatus() {
		return sendStatus;
	}

	public void setSendStatus(Integer sendStatus) {
		this.sendStatus = sendStatus;
	}

	public Integer getTrial() {
		return trial;
	}

	public void setTrial(Integer trial) {
		this.trial = trial;
	}

	public String getEpubSegExp() {
		return epubSegExp;
	}

	public void setEpubSegExp(String epubSegExp) {
		this.epubSegExp = epubSegExp;
	}

	public String getProbationPer() {
		return probationPer;
	}

	public void setProbationPer(String probationPer) {
		this.probationPer = probationPer;
	}

	public String getProbationValue() {
		return probationValue;
	}

	public void setProbationValue(String probationValue) {
		this.probationValue = probationValue;
	}

	public Integer getContinuousPrint() {
		return continuousPrint;
	}

	public void setContinuousPrint(Integer continuousPrint) {
		this.continuousPrint = continuousPrint;
	}

	public Integer getProbationStatus() {
		return probationStatus;
	}

	public void setProbationStatus(Integer probationStatus) {
		this.probationStatus = probationStatus;
	}
	
	
	
	

	
}
