package cn.digitalpublishing.thread;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.digitalpublishing.dao.BInstitutionDao;
import cn.digitalpublishing.ep.po.BInstitution;
import cn.digitalpublishing.ep.po.LAccess;
import cn.digitalpublishing.redis.dao.BookDao;
import cn.digitalpublishing.service.factory.ServiceFactory;
import cn.digitalpublishing.service.factory.impl.ServiceFactoryImpl;

public class TriggerIndexHotWords extends Thread {

	//public Logger log = Logger.getLogger(TriggerIndexHotWords.class);
	private ServiceFactory serviceFactory;
	private BookDao bookDao;

	public TriggerIndexHotWords(BookDao bd) {
		this.serviceFactory = (ServiceFactory) new ServiceFactoryImpl();
		this.bookDao = bd;
	}

	@Override
	public void run() {
		tigger();
	}

	private void tigger() {
		System.out.println("首页检索热词更新开始.......");
		long starttime = System.currentTimeMillis();
		try {
			
			/*
			 * 遍历出机构
			 */
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("status", 1);//1 正常 2 异常
			List<BInstitution> instlist = serviceFactory.getConfigureService().getInstitutionList(condition, " ");
			condition.clear();
			String ins_Id = "";
			//需要初始化ip外数据
			BInstitution bean = new BInstitution();
			bean.setId("");
			instlist.add(bean);
			
			for(BInstitution inst : instlist){
				
				ins_Id = inst.getId();
				//System.out.println(ins_Id);
				condition.put("type", 3); // 操作类型1-访问摘要 2-访问内容 3-检索				
				condition.put("institutionId", ins_Id);
				condition.put("keywordNotNull", 1);
				condition.put("createOn", -30); // 30 天前的搜索数据
				List<LAccess> list = serviceFactory.getLogAOPService().getLogOfHotWords(condition, " GROUP BY a.activity ORDER BY count(*) DESC ", 9, 0);
				// <a class="span1" href="javascript:;" onclick="searchByCondition('searchValue', '美国科研出版社')" title="美国科研出版社">美国科研出版社</a>
				bookDao.setValueByKey(ins_Id+"__hotWords", "");
				int size = list.size();
				//System.out.println(size);
				for (int i = 0; i < size; i++) {
					bookDao.append(ins_Id+"__hotWords", "<a class=\"span" + (i + 1) + "\" href=\"javascript:;\" onclick=\"searchByCondition('searchValue', '" + list.get(i).getActivity() + "')\" title=\"" + list.get(i).getActivity() + "\">" + list.get(i).getActivity() + "</a>");
				}				
			}			
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		System.out.println("首页检索热词更新完成! 用时："+(System.currentTimeMillis()-starttime)+".ms");
	}
	
	/*private void tigger() {
		System.out.println("首页检索热词更新开始.......");

		try {
			//bookDao.delete("hotWords");			 
			Map<String, Object> condition = new HashMap<String, Object>();
						
			condition.put("type", 3); // 操作类型1-访问摘要 2-访问内容 3-检索
			String ins_Id = "";
			condition.put("institutionId", ins_Id);
			condition.put("keywordNotNull", 1);
			condition.put("createOn", -30); // 30 天前的搜索数据
			List<LAccess> list = serviceFactory.getLogAOPService().getLogOfHotWords(condition, " GROUP BY a.activity ORDER BY count(*) DESC ", 9, 0);
			// <a class="span1" href="javascript:;" onclick="searchByCondition('searchValue', '美国科研出版社')" title="美国科研出版社">美国科研出版社</a>
			bookDao.setValueByKey("hotWords", "");
			int size = list.size();
			for (int i = 0; i < size; i++) {
				bookDao.append("hotWords", "<a class=\"span" + (i + 1) + "\" href=\"javascript:;\" onclick=\"searchByCondition('searchValue', '" + list.get(i).getActivity() + "')\" title=\"" + list.get(i).getActivity() + "\">" + list.get(i).getActivity() + "</a>");
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}

		System.out.println("首页检索热词更新完成!");
	}*/

}
