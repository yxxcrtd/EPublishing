package cn.digitalpublishing.service;

import java.util.List;
import java.util.Map;

import cn.digitalpublishing.ep.po.PEpubAnnotation;
import cn.digitalpublishing.ep.po.PNote;

public interface PNoteService extends BaseService {
	/**
	 * 新增pdf
	 * @param obj
	 * @throws Exception
	 */
	public void addNote(PNote obj)throws Exception;
	
	/**
	 * 获取pdf
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public PNote getNote(String id)throws Exception;
	/**
	 * 删除pdf
	 * @param id
	 * @param path
	 * @throws Exception
	 */
	public void deleteNote(String id)throws Exception;
	
	/**
	 * 获取列表
	 * @param condition
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	public List<PNote> getNoteList(Map<String,Object> condition,String sort)throws Exception;
	/**
	 * 获取分页列表
	 * @param condition
	 * @param sort
	 * @param pageCount
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PNote> getNotePagingList(Map<String,Object> condition,String sort,Integer pageCount,Integer page)throws Exception;
	/**
	 * 获取总数
	 * @param condition
	 * @return
	 * @throws Exception
	 */
	public Integer getNoteCount(Map<String,Object> condition)throws Exception;

	/**
	 * 更新笔记
	 * @param note
	 * @throws Exception
	 */
	public void updateNote(PNote note)throws Exception;
	/**
	 * 按条件删除EPUB笔记
	 * @param condition
	 * @throws Exception
	 */
	public void delEBAnnos(Map<String,Object> condition)throws Exception;
	/**
	 * 按ID删除EPUB笔记
	 * @param id
	 * @throws Exception
	 */
	public void delEBAnno(String id)throws Exception;
	/**
	 * 更新EPUB笔记
	 * @param anno
	 * @throws Exception
	 */
	public void updateEBAnno(PEpubAnnotation anno)throws Exception;
	/**
	 * 查询EPUB笔记列表
	 * @param condition
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	public List<PEpubAnnotation> getEBAnnos(Map<String,Object> condition,String sort)throws Exception;
	/**
	 * 保存EPUB笔记
	 * @param mark
	 * @throws Exception
	 */
	public void saveAnnotation(PEpubAnnotation anno)throws Exception;

	
}
