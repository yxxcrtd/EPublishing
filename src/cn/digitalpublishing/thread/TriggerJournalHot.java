package cn.digitalpublishing.thread;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.digitalpublishing.ep.po.BInstitution;
import cn.digitalpublishing.ep.po.LAccess;
import cn.digitalpublishing.redis.dao.BookDao;
import cn.digitalpublishing.service.factory.ServiceFactory;
import cn.digitalpublishing.service.factory.impl.ServiceFactoryImpl;

/**
 * 二级页面-中文电子期刊页-热读资源
 * 
 * @author liangkeqiang
 *
 */
public class TriggerJournalHot extends Thread {
	private ServiceFactory serviceFactory;
	private BookDao bookDao;

	public TriggerJournalHot(BookDao bd) {
		this.serviceFactory = (ServiceFactory) new ServiceFactoryImpl();
		this.bookDao = bd;
	}

	@Override
	public void run() {
		tigger();
	}

	private void tigger() {
		System.out.println("中文电子期刊热读资源更新开始!-------->  当前时间：" + new Date());
		try {
			List<BInstitution> binsList = serviceFactory.getConfigureService().getInstitutionList(null, "");
			Map<String, Object> ucMap = new HashMap<String, Object>();
			ucMap.put("ava", 2);
			ucMap.put("pStatus", 2);
			ucMap.put("pType", 7); // 期
			ucMap.put("language", "ch%");
			for (BInstitution ins : binsList) {
				ucMap.put("noLicense", true);
				ucMap.put("noOrder", true);
				ucMap.put("pInsId", ins.getId());
				List<LAccess> list = serviceFactory.getLogAOPService().getLogOfHotReadingForRecommad(ucMap,
						" group by b.id order by count(a.id) desc ", 24, 0);
				if (list.size() >= 24) {
					bookDao.delete(ins.getId() + "__JournalHot");
					for (LAccess a : list) {
						System.out.println("插入Redis -> 机构ID：" + ins.getId() + " - 机构名称：" + ins.getName() + " - 资源ID："
								+ a.getPublications().getId() + " - 资源名称：" + a.getPublications().getTitle()
								+ "##publisher##" + a.getPublications().getPublisher().getName() + "##start##"
								+ a.getPublications().getStartVolume() + "##end##"
								+ a.getPublications().getEndVolume());
						bookDao.zadd(ins.getId() + "__JournalHot",
								a.getPublications().getId() + a.getPublications().getTitle() + "##publisher##"
										+ a.getPublications().getPublisher().getName() + "##start##"
										+ a.getPublications().getStartVolume() + "##end##"
										+ a.getPublications().getEndVolume() + "##license##1" + "##oa##"
										+ a.getPublications().getOa() + "##free##" 
										+ a.getPublications().getFree()+"##cover##"
										+a.getPublications().getCover()+"##year##"
										+a.getPublications().getYear()+"##volumeCode##"
										+a.getPublications().getVolumeCode()+"##issueCode##"
										+a.getPublications().getIssueCode());
					}

				} else {
					List<String> recommendList = bookDao.getSet("JournalHot");
					if (recommendList.size() == 0) {
						ucMap.remove("noLicense");
						ucMap.remove("noOrder");
						ucMap.remove("pInsId");
						list = serviceFactory.getLogAOPService().getLogOfHotReadingForRecommad(ucMap,
								" group by b.id order by count(a.id) desc ", 24, 0);
						for (LAccess a : list) {
							bookDao.zadd("JournalHot",
									a.getPublications().getId() + a.getPublications().getTitle() + "##publisher##"
											+ a.getPublications().getPublisher().getName() + "##start##"
											+ a.getPublications().getStartVolume() + "##end##"
											+ a.getPublications().getEndVolume() + "##license##0" + "##oa##"
											+ a.getPublications().getOa() + "##free##" + a.getPublications().getFree()+"##cover##"+a.getPublications().getCover()
											+"##year##"
											+a.getPublications().getYear()+"##volumeCode##"
											+a.getPublications().getVolumeCode()+"##issueCode##"
											+a.getPublications().getIssueCode());
						}
					}

				}
			}

		
		} catch (

		Exception e)

		{
			e.printStackTrace();
		}

		System.out.println("中文电子期刊热读资源更新完成!-------->  当前时间：" + new Date());
	}
}
