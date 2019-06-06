package cn.digitalpublishing.service.impl;

import java.util.List;
import java.util.Map;

import cn.com.daxtech.framework.exception.CcsException;
import cn.digitalpublishing.ep.po.PEpubAnnotation;
import cn.digitalpublishing.ep.po.PNote;
import cn.digitalpublishing.service.PNoteService;

public class PNoteServiceImpl extends BaseServiceImpl implements PNoteService {

	public void addNote(PNote obj)throws Exception {
		try {
			this.daoFacade.getpNoteDao().insert(obj);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "Note.info.add.error", e);//添加笔记信息失败！
		}
	}

	public PNote getNote(String id) throws Exception {
		PNote notes = null;
		try {
			notes = (PNote)this.daoFacade.getpNoteDao().get(PNote.class.getName(), id);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "Note.info.get.error", e);//获取笔记信息失败！
		}
		return notes;
	}

	public void deleteNote(String id) throws Exception {
		try {
			this.daoFacade.getpNoteDao().delete(PNote.class.getName(), id);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "Note.info.delete.error", e);//删除笔记信息失败！
		}
	}

	public List<PNote> getNoteList(Map<String, Object> condition,
			String sort) throws Exception {
		List<PNote> list = null;
		try {
			list = this.daoFacade.getpNoteDao().getList(condition, sort);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	:"Note.info.list.error", e);//获取笔记信息列表失败！
		}
		return list;
	}

	public List<PNote> getNotePagingList(Map<String, Object> condition,
			String sort, Integer pageCount, Integer page) throws Exception {
		List<PNote> list = null;
		try {
			list = this.daoFacade.getpNoteDao().getPagingList(condition, sort, pageCount, page);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "Note.info.pagelist.error", e);//获取笔记信息分页列表失败！
		}
		return list;
	}

	public Integer getNoteCount(Map<String, Object> condition) throws Exception {
		Integer num = 0;
		try {
			num = this.daoFacade.getpNoteDao().getCount(condition);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "Note.info.count.error", e);//获取笔记信息总数失败！
		}
		return num;
	}

	public void updateNote(PNote note) throws Exception {
		try {
			this.daoFacade.getpNoteDao().update(note, PNote.class.getName(), note.getId(), null);
		} catch (Exception e) {
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "Note.info.add.error", e);//添加笔记信息失败！
		}
	}
	
	
	/**
	 * 按条件删除EPUB笔记
	 * @param condition
	 * @throws Exception
	 */
	public void delEBAnnos(Map<String,Object> condition)throws Exception{
		
	}
	/**
	 * 按ID删除EPUB笔记
	 * @param id
	 * @throws Exception
	 */
	public void delEBAnno(String id)throws Exception{
		try{
			this.daoFacade.getpEpubAnnotationDao().delete(PEpubAnnotation.class.getName(),id);
		}catch(Exception e){
			throw e;
		}
	}
	
	public void updateEBAnno(PEpubAnnotation anno)throws Exception{
		try{
			this.daoFacade.getpEpubAnnotationDao().update(anno,PEpubAnnotation.class.getName(),anno.getId(),null);
		}catch(Exception e){
			throw e;
		}
	}
	
	/**
	 * 查询EPUB笔记列表
	 * @param condition
	 * @return
	 * @throws Exception
	 */
	public List<PEpubAnnotation> getEBAnnos(Map<String,Object> condition,String sort)throws Exception{
		try{
			return this.daoFacade.getpEpubAnnotationDao().getList(condition, sort);
		}catch(Exception e){
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "Note.info.list.error", e);//添加笔记信息失败！
		}
	}
	
	/**
	 * 保存EPUB笔记
	 * @param mark
	 * @throws Exception
	 */
	public void saveAnnotation(PEpubAnnotation anno)throws Exception{
		try{
			this.daoFacade.getpEpubAnnotationDao().insert(anno);
		}catch(Exception e){
			e.printStackTrace();
			throw new CcsException((e instanceof CcsException) ? e.getMessage()	: "Note.info.add.error", e);//添加笔记信息失败！
		}
	}

	
}
