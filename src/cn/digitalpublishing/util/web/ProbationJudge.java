package cn.digitalpublishing.util.web;

import java.text.NumberFormat;
import java.text.ParseException;

import cn.digitalpublishing.ep.po.BPublisher;
import cn.digitalpublishing.ep.po.EBSource;
import cn.digitalpublishing.ep.po.PPublications;

public class ProbationJudge {

	/***
	 * <试读> 判断是否能够进行试读
	 * 
	 * @param p
	 * @return boolean
	 */
	public static boolean judgeEnableProbation(PPublications p) {
		boolean flag = false;
		try {
			if (null != p.getPublisher() && 1 == p.getType()) {
				// 非试读状态
				if (p.getOa() == 2 || p.getFree() == 2 || (null != p.getExLicense() && p.getExLicense() == 1) || (null != p.getBuyInDetail() && p.getBuyInDetail() == 1)
						|| (null != p.getSubscribedUser() && p.getSubscribedUser() == 1) || (null != p.getSubscribedIp() && p.getSubscribedIp() == 1)) {
					// 试读( 根据提供商判断是否可以试读 )
				}else if (null != p.getProbation() && p.getProbation() == 1) {
					flag = true;
				} 				
				/** 需求：现在不在判断用户是否在IP范围内了  */
				/*else if ((null != p.getRecommand() && p.getRecommand() == 1)
				&& (null != p.getProbation() && p.getProbation() == 1)) {
					flag = true;
				}*/
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}

	/**
	 * <试读> 根据（出版商）计算出试读的页数
	 * 
	 * @param PPublications
	 *            p
	 * @return Long
	 */
	@SuppressWarnings("finally")
	public static Long getAcademicProbationPageNum(PPublications p) {
		// 出版商
		long pageNum = 0;
		long percentageNum = 0;
		long probationValueNum = 0;
		try {
			BPublisher bPublisher = p.getPublisher();
			NumberFormat nf = NumberFormat.getPercentInstance();
			if (bPublisher != null) {
				String probationPer = bPublisher.getProbationPer();
				String probationValue = bPublisher.getProbationValue();
				percentageNum = (null == probationPer || "".equals(probationPer) || "0".equals(probationPer)) ? 0 : Math.round(Integer.parseInt(p.getPageNumCount())
						* (nf.parse(probationPer).doubleValue())) >= 1 ? Math.round(Integer.parseInt(p.getPageNumCount()) * (nf.parse(probationPer).doubleValue())) : 1;
				probationValueNum = (null == probationValue || "".equals(probationValue) || "0".equals(probationValue)) ? 0 : Long.parseLong(probationValue) >= 1 ? (Long
						.parseLong(probationValue)<=Integer.parseInt(p.getPageNumCount()) ? Long.parseLong(probationValue): Long.parseLong(p.getPageNumCount())) : 1;
				// pageNum = percentageNum >= probationValueNum ?
				// probationValueNum : percentageNum ;
				if (percentageNum > 0 && probationValueNum > 0) {
					pageNum = percentageNum >= probationValueNum ? probationValueNum : percentageNum;
				} else if (probationValueNum == 0) {
					pageNum = percentageNum;
				} else if (percentageNum == 0) {
					pageNum = probationValueNum;
				}
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			return pageNum;
		}
	}

	/**
	 * <试读> 根据（提供商）计算出试读的页数
	 * 
	 * @param PPublications
	 *            p
	 * @return Long
	 */
	@SuppressWarnings("finally")
	public static Long getAcademicProbationPageNum_source(EBSource source, long pageNumCount) {
		// 提供商
		long pageNum = 0;
		long percentageNum = 0;
		long probationValueNum = 0;
		try {
			// BPublisher bPublisher = p.getPublisher();
			NumberFormat nf = NumberFormat.getPercentInstance();
			if (source != null) {
				String probationPer = source.getProbationPer();
				String probationValue = source.getProbationValue();
				percentageNum = (null == probationPer || "".equals(probationPer) || "0".equals(probationPer)) ? 0 : Math.round(pageNumCount
						* (nf.parse(probationPer).doubleValue())) >= 1 ? Math.round(pageNumCount * (nf.parse(probationPer).doubleValue())) : 1;
				probationValueNum = (null == probationValue || "".equals(probationValue) || "0".equals(probationValue)) ? 0 : Long.parseLong(probationValue) >= 1 ? (Long
						.parseLong(probationValue)<=pageNumCount ? Long.parseLong(probationValue): pageNumCount) : 1;
				if (percentageNum > 0 && probationValueNum > 0) {
					pageNum = percentageNum >= probationValueNum ? probationValueNum : percentageNum;
				} else if (probationValueNum == 0) {
					pageNum = percentageNum;
				} else if (percentageNum == 0) {
					pageNum = probationValueNum;
				}
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			return pageNum;
		}

	}

}
