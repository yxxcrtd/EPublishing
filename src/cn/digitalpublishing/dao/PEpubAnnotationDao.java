package cn.digitalpublishing.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.com.daxtech.framework.util.CollectionsUtil;
import cn.digitalpublishing.ep.po.PEpubAnnotation;
import cn.digitalpublishing.ep.po.PEpubBookmark;

public class PEpubAnnotationDao extends CommonDao<PEpubAnnotation,String> {
	
	private Map<String,Object> getWhere(Map<String,Object> map){
		Map<String,Object> table=new HashMap<String,Object>();
		String whereString="";
		List<Object> condition=new ArrayList<Object>();
		int flag=0;				
				
		/**
		 * id
		 */
		if(CollectionsUtil.exist(map, "id")&&!"".equals(map.get("id"))){
			if(flag==0){
				whereString+=" where a.id = ?";
				flag=1;
			}else{
				whereString+=" and a.id = ? ";
			}
			condition.add(map.get("id"));
		}
		/**
		 * pubId
		 */
		if(CollectionsUtil.exist(map, "pubId")&&!"".equals(map.get("pubId"))){
			if(flag==0){
				whereString+=" where b.id = ?";
				flag=1;
			}else{
				whereString+=" and b.id = ? ";
			}
			condition.add(map.get("pubId"));
		}
		/**
		 * userId
		 */
		if(CollectionsUtil.exist(map, "userId")&&!"".equals(map.get("userId"))){
			if(flag==0){
				whereString+=" where c.id = ?";
				flag=1;
			}else{
				whereString+=" and c.id = ? ";
			}
			condition.add(map.get("userId"));
		}
		if(CollectionsUtil.exist(map, "paraIds") && !"".equals(map.get("paraIds"))){
			String[] arr=map.get("paraIds").toString().split(",");
			if(arr!=null && arr.length>0){
				String param="(";
				for(Integer i=0;i<arr.length;i++){
					param+="?";
					if(i<arr.length-1){
						param+=",";  
					}
					condition.add(arr[i].trim());
				}
				param +=") ";	
				if(flag==0){
					whereString+=" where a.startContainerId in " + param  ;
					flag=1;
				}else{
					whereString+=" and a.startContainerId in " + param;
				}
			}
		}
		table.put("where",whereString);
		table.put("condition", condition);
		return table;
	}
	
	/**
	 * 获取配置列表
	 * @param condition
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PEpubAnnotation> getList(Map<String,Object> condition,String sort)throws Exception{
		List<PEpubAnnotation> list=null;
		String hql=" from PEpubAnnotation a inner join a.publications b inner join a.user c ";
		Map<String,Object> t=this.getWhere(condition);
		String property=" id,type,note,text,middleContainers,startContainerId,endContainerId,startOffset,endOffset,visiblePrivate,createOn,publications.id,user.id,user.name";
		String field=" a.id,a.type,a.note,a.text,a.middleContainers,a.startContainerId,a.endContainerId,a.startOffset,a.endOffset,a.visiblePrivate,a.createOn,b.id,c.id,c.name";
		try{
			list=super.hibernateDao.getListByHql(property,field, hql+t.get("where").toString(), ((List<Object>)t.get("condition")).toArray(),sort, PEpubAnnotation.class.getName());
		}catch(Exception e){
			throw e;
		}
		return list;
	}
	/**
	 * 获取分页信息
	 * @param condition
	 * @param sort
	 * @param pageCount
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PEpubAnnotation> getPagingList(Map<String,Object> condition,String sort,Integer pageCount,Integer page)throws Exception{
		List<PEpubAnnotation> list=null;
		String hql=" from PEpubAnnotation a inner join a.publications b inner join a.user c ";
		Map<String,Object> t=this.getWhere(condition);
		String property=" id,type,note,text,middleContainers,startContainerId,endContainerId,startOffset,endOffset,visiblePrivate,createOn,publications.id,user.id,user.name";
		String field=" a.id,a.type,a.note,a.text,a.middleContainers,a.startContainerId,a.endContainerId,a.startOffset,a.endOffset,a.visiblePrivate,a.createOn,b.id,c.id,c.name";
		try{
			list=super.hibernateDao.getListByHql(property,field, hql+t.get("where").toString(), ((List<Object>)t.get("condition")).toArray(),sort, PEpubAnnotation.class.getName(),pageCount,page*pageCount);
		}catch(Exception e){
			throw e;
		}
		return list;
	}
	/**
	 * 获取总数
	 * @param condition
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Integer getCount(Map<String,Object> condition)throws Exception{
		List<PEpubAnnotation> list=null;
		Map<String,Object> t=this.getWhere(condition);
		String hql=" from PEpubAnnotation a inner join a.publications b  inner join a.user c ";
		try{
			list=this.hibernateDao.getListByHql("id","cast(count(*) as string)", hql+t.get("where").toString(), ((List<Object>)t.get("condition")).toArray(),"", PEpubAnnotation.class.getName());
		}catch(Exception e){
			throw e;
		}
		return list==null?0:Integer.valueOf(list.get(0).getId());
	}

}
