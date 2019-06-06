package cn.digitalpublishing.util.bean;

public class ProbationInfo {

	private String pubId;
	private long limitPageNum;
	private long timestamp;

	public ProbationInfo() {
	}

	public ProbationInfo(String pubId, long limitPageNum, long timestamp) {
		super();
		this.pubId = pubId;
		this.limitPageNum = limitPageNum;
		this.timestamp = timestamp;
	}

	public String getPubId() {
		return pubId;
	}

	public void setPubId(String pubId) {
		this.pubId = pubId;
	}

	public long getLimitPageNum() {
		return limitPageNum;
	}

	public void setLimitPageNum(long limitPageNum) {
		this.limitPageNum = limitPageNum;
	}

	public long getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(long timestamp) {
		this.timestamp = timestamp;
	}

}
