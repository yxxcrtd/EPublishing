package cn.digitalpublishing.thread;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.util.DateUtil;

import cn.digitalpublishing.ep.po.BInstitution;
import cn.digitalpublishing.service.factory.ServiceFactory;
import cn.digitalpublishing.service.factory.impl.ServiceFactoryImpl;
import cn.digitalpublishing.springmvc.form.product.BookSuppliersForm;

public class ProviderStatisticalIndexProcess extends Thread {

	private ServiceFactory serviceFactory;

	private ProviederStatisticalCounter counter;

	public ProviderStatisticalIndexProcess(ProviederStatisticalCounter counter) {
		this.serviceFactory = (ServiceFactory) new ServiceFactoryImpl();
		this.counter = counter;
	}

	@Override
	public void run() {
		Boolean b = true;
		if (b) {
			// 测试通过后取消这设置
			this.onConvertbatches();
		}
		counter.countDown();
	}

	/**
	 * 提供商统计信息 实时执行统计
	 * by heqing.yang 2015-01-24
	 * @throws Exception 
	 */
	private void onConvertbatches() {

		try {
			System.out.println("start:+++++++++++++++++Supplier+++++Supplier+++++Supplier++++----------------");
			Map<String, Object> condition = new HashMap<String, Object>();
			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
			String dateString = formatter.format(date);
			//condition.put("institutionId", "40288a9c4bf38c0d014c2182cbfe7b96");
			//condition.put("accessON", 0);
			Integer count = serviceFactory.getBookSuppliersService().getSSupplierCount(condition);

			condition.clear();
			//condition.put("institutionId", "40288a9c4bf38c0d014c2182cbfe7b96");
			List<BInstitution> binsList = serviceFactory.getConfigureService().getInstitutionList(condition, "");
			if (count == 0) {
				//只在程序开始运行时统计一遍全部的
				BookSuppliersForm form = new BookSuppliersForm();
				form.setEndYear(Integer.parseInt(dateString));
				for (int i = form.getStartYear(); i <= form.getEndYear(); i++) {
					form.getYearList().add(String.valueOf(i));
				}

				if (binsList != null && binsList.size() > 0) {
					for (BInstitution obj : binsList) {
						System.out.println("当前机构ID：" + obj.getId() + " Code:" + obj.getCode() + " Name:" + obj.getName() + " - " + new Date());
						for (int i = 0; i < form.getYearList().size(); i++) {
							//BInstitution obj = new BInstitution();
							//obj.setId("ff8080813c69a8fd013c6a554b350253");
							System.out.println("统计开始" + new Date());

							serviceFactory.getBookSuppliersService().getSupplierFast(1, null, null, null, form.getYearList().get(i), obj.getId());//写入toc访问统计
							System.out.println("toc访问统计" + new Date());

							serviceFactory.getBookSuppliersService().getSupplierFast(2, 1, null, null, form.getYearList().get(i), obj.getId());//写入访问成功统计
							System.out.println("访问成功" + new Date());

							serviceFactory.getBookSuppliersService().getSupplierFast(2, 2, null, null, form.getYearList().get(i), obj.getId());//写入拒绝访问统计
							System.out.println("拒绝访问" + new Date());

							serviceFactory.getBookSuppliersService().getSupplierFast(2, 2, 1, null, form.getYearList().get(i), obj.getId());//写入全文访问没有license（月）统计总数
							System.out.println("全文访问（没有License）" + new Date());

							serviceFactory.getBookSuppliersService().getSupplierFast(2, 2, 2, null, form.getYearList().get(i), obj.getId());//写入全文访问超并发数（月）统计总数
							System.out.println("全文访问（超并发数）" + new Date());

							serviceFactory.getBookSuppliersService().getSupplierFast(3, null, null, null, form.getYearList().get(i), obj.getId());//写入搜索（月）统计总数
							System.out.println("搜索统计" + new Date());

							serviceFactory.getBookSuppliersService().getSupplierFast(4, null, null, null, form.getYearList().get(i), obj.getId());//写入下载(月)统计总数
							System.out.println("下载统计" + new Date());

						}
					}
				}
				System.out.println("全部统计结束！" + new Date());

			}
			/**
			 * chensr 2015-11-18 修改
			 */
			long starttime = System.currentTimeMillis();
			String year = DateUtil.formatDate(date, "yyyy");
			String month = DateUtil.formatDate(date, "MM");
			if (binsList != null && binsList.size() > 0) {
				for (BInstitution obj : binsList) {
					//
					serviceFactory.getBookSuppliersService().getSupplierFast_v2(1, null, null, month, year, obj.getId(),null);//写入toc访问统计
					
					serviceFactory.getBookSuppliersService().getSupplierFast_v2(2, 1, null, month, year, obj.getId(),null);//写入访问成功统计  全文
					serviceFactory.getBookSuppliersService().getSupplierFast_v2(2, 2, null, month, year, obj.getId(),null);//写入拒绝访问统计  全文
					serviceFactory.getBookSuppliersService().getSupplierFast_v2(2, 2, 1, month, year, obj.getId(),null);//写入全文访问没有license（月）统计总数 全文
					serviceFactory.getBookSuppliersService().getSupplierFast_v2(2, 2, 2, month, year, obj.getId(),null);//写入全文访问超并发数（月）统计总数           全文

					serviceFactory.getBookSuppliersService().getSupplierFast_v2(2, 1, null, month, year, obj.getId(),1);//写入访问成功统计  全文  1-试读,2-试用,3-购买资源
					serviceFactory.getBookSuppliersService().getSupplierFast_v2(2, 1, null, month, year, obj.getId(),2);//写入访问成功统计  全文  1-试读,2-试用,3-购买资源 
					serviceFactory.getBookSuppliersService().getSupplierFast_v2(2, 1, null, month, year, obj.getId(),3);//写入访问成功统计  全文  1-试读,2-试用,3-购买资源
					
					serviceFactory.getBookSuppliersService().getSupplierFast_v2(3, null, null, month, year, obj.getId(),null);//写入搜索（月）统计总数
					serviceFactory.getBookSuppliersService().getSupplierFast_v2(4, null, null, month, year, obj.getId(),null);//写入下载(月)统计总数
				}
			}
			System.out.println(DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss")+"-----all task is ok!! take time is "+(System.currentTimeMillis()-starttime)+"--------------");
			//}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			counter.countDown();
		}

	}

}
