package cn.digitalpublishing.service.impl;

import java.util.List;
import java.util.Map;

import cn.com.daxtech.framework.exception.CcsException;
import cn.digitalpublishing.ep.po.PEpubBookmark;
import cn.digitalpublishing.ep.po.PRecord;
import cn.digitalpublishing.service.PRecordService;

public class PRecordServiceImpl extends BaseServiceImpl implements
		PRecordService {

	@Override
	public void addRecord(PRecord obj) throws Exception {
		try {
			this.daoFacade.getpRecordDao().insert(obj);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "PRecord.info.add.error", e);//添加标签信息失败！
		}
	}

	@Override
	public PRecord getPRecord(String id) throws Exception {
		PRecord PRecord = null;
		try {
			PRecord = (PRecord)this.daoFacade.getpRecordDao().get(PRecord.class.getName(), id);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "PRecord.info.get.error", e);//获取标签信息失败！
		}
		return PRecord;
	}

	@Override
	public void deletePRecord(String id, String path) throws Exception {
		try {
			this.daoFacade.getpRecordDao().delete(PRecord.class.getName(), id);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "PRecord.info.delete.error", e);//删除标签信息失败！
		}
	}

	@Override
	public List<PRecord> getPRecordList(Map<String, Object> condition, String sort)
			throws Exception {
		List<PRecord> list = null;
		try {
			list = this.daoFacade.getpRecordDao().getList(condition, sort);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "PRecord.info.list.error", e);//获取标签信息列表失败！
		}
		return list;
	}

	@Override
	public List<PRecord> getPRecordPagingList(Map<String, Object> condition,
			String sort, Integer pageCount, Integer page) throws Exception {
		List<PRecord> list = null;
		try {
			list = this.daoFacade.getpRecordDao().getPagingList(condition, sort, pageCount, page);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "PRecord.info.pagelist.error", e);//获取标签信息分页列表失败！
		}
		return list;
	}

	@Override
	public Integer getPRecordCount(Map<String, Object> condition)
			throws Exception {
		Integer num = 0;
		try {
			num = this.daoFacade.getpRecordDao().getCount(condition);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	:"PRecord.info.count.error", e);//获取标签信息总数失败！
		}
		return num;
	}

	@Override
	public void deleteBySourceId(String sourceId,String userId) throws Exception {
		try {
			this.daoFacade.getpRecordDao().deleteBySourceId(sourceId,userId);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "PRecord.info.delete.error", e);//删除标签信息失败！
		}
	}
	
	/**
	 * 按条件删除EPUB书签
	 * @param condition
	 * @throws Exception
	 */
	public void delEBMarks(Map<String,Object> condition)throws Exception{
		
	}
	/**
	 * 按ID删除EPUB书签
	 * @param id
	 * @throws Exception
	 */
	public void delEBMarks(String id)throws Exception{
		try{
			this.daoFacade.getpEpubBookmarkDao().delete(PEpubBookmark.class.getName(),id);
		}catch(Exception e){
			throw e;
		}
	}
	
	/**
	 * 查询EPUB书签列表
	 * @param condition
	 * @return
	 * @throws Exception
	 */
	public List<PEpubBookmark> getEBMarks(Map<String,Object> condition,String sort)throws Exception{
		try{
			return this.daoFacade.getpEpubBookmarkDao().getList(condition, sort);
		}catch(Exception e){
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "Note.info.add.error", e);//添加笔记信息失败！
		}
	}
	
	
	/**
	 * 保存EPUB书签
	 * @param mark
	 * @throws Exception
	 */
	public void saveEBMark(PEpubBookmark mark)throws Exception{
		try{
			this.daoFacade.getpEpubBookmarkDao().insert(mark);
		}catch(Exception e){
			e.printStackTrace();
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "Note.info.add.error", e);//添加笔记信息失败！
		}
	}

}
