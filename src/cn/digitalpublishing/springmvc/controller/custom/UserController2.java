package cn.digitalpublishing.springmvc.controller.custom;

import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.com.daxtech.framework.Internationalization.Lang;
import cn.digitalpublishing.ep.po.BInstitution;
import cn.digitalpublishing.ep.po.CUser;
import cn.digitalpublishing.ep.po.LLicense;
import cn.digitalpublishing.springmvc.controller.BaseController;
import cn.digitalpublishing.springmvc.form.custom.LLicenseForm;
import cn.digitalpublishing.util.web.DateUtil;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

@Controller
@RequestMapping("/pages/user2")
public class UserController2 extends BaseController {

	@RequestMapping(value = "/form/Log")
	public void mySubscriptionLog(HttpServletRequest request, HttpServletResponse response, HttpSession session, LLicenseForm form) {
		try {
			List<LLicense> list = null;
			CUser user = (CUser) session.getAttribute("mainUser");
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("status", 1);
			condition.put("available", 3);//这是过滤图书是政治原因的条件
			condition.put("end_time", new Date());
			String ptype = request.getParameter("pType");
			String isCn = request.getParameter("isCn");
			if (isCn != null && !"".equals(isCn)) {
				condition.put("isCn", isCn);
			}
			//			if (ptype != null && !"".equals(ptype)) {
			//				condition.put("pType", ptype);
			//			}
			if (form.getSearchType() != null && !"".equals(form.getSearchType())) {
				if (form.getSearchType() == 1) {
					condition.put("searchType", new Integer[] { 1, 3 });// 图书
																		// 、章节
				} else if (form.getSearchType() == 2) {
					condition.put("searchType", new Integer[] { 2, 4, 6, 7 });
					if (ptype != null && !"".equals(ptype)) {
						int pType = Integer.parseInt(ptype);
						if (pType == 1) {// 刊
							condition.put("searchType", new Integer[] { 2 });
						} else if (pType == 2) {// 文章
							condition.put("searchType", new Integer[] { 4 });
						} else if (pType == 7) {// 期
							condition.put("searchType", new Integer[] { 7 });
						} else if (pType == 4) {// 期  && 刊
							condition.put("searchType", new Integer[] { 2, 6, 7 });
						}
					}
				} else if (form.getSearchType() == 3) {
					condition.put("searchType", new Integer[] { 5 });
				} else if (form.getSearchType() == 99) {
					condition.put("collections", "0");
				}
			}

			/**
			 * 查看范围 1-个人订阅 2-机构订阅 3-所有
			 */
			if (form.getRange() == null || form.getRange() == 3) {
				condition.put("userid", user.getId());
				if (session.getAttribute("institution") != null) {// 查看session中保存的机构订阅信息
					condition.put("level", 2);
					condition.put("institutionId", ((BInstitution) session.getAttribute("institution")).getId());
				}
				list = this.customService.getLicenseList(condition, "order by a.createdon desc ");
			} else if (form.getRange() == 1) {
				condition.put("userid", user.getId());
				list = this.customService.getLicenseList(condition, "order by a.createdon desc ");
			} else if (form.getRange() == 2) {

				if (user.getInstitution() != null && user.getInstitution().getId() != null) {
					condition.put("level", 2);
					condition.put("isTrail", "0");
					condition.put("institutionId", user.getInstitution().getId());
					list = this.customService.getLicenseList(condition, "order by a.createdon desc ");
				} else if (session.getAttribute("institution") != null) {

					if (user.getInstitution() != null && user.getInstitution().getId() != null) {// 查看session中登录用户的机构订阅信息
						condition.put("level", 2);
						condition.put("isTrail", "0");
						condition.put("available", 3);//这是过滤图书是政治原因的条件
						condition.put("institutionId", user.getInstitution().getId());
						list = this.customService.getLicenseList(condition, "order by a.createdon desc ");
					} else if (session.getAttribute("institution") != null) {// 查看session中保存的机构订阅信息

						condition.put("status", 1);
						condition.put("isTrail", "0");
						condition.put("level", 2);
						condition.put("institutionId", ((BInstitution) session.getAttribute("institution")).getId());
						list = this.customService.getLicenseList(condition, "order by a.createdon desc ");

					}

					/*
					 * if (session.getAttribute("institution") != null) {//
					 * 查看session中保存的机构订阅信息 condition.put("status", 1);
					 * condition.put("isTrail", "0"); condition.put("level", 2);
					 * condition.put("institutionId", ((BInstitution)
					 * session.getAttribute("institution")).getId()); list =
					 * this.customService.getLicenseList(condition,
					 * "order by a.createdon desc "); } else if
					 * (user.getInstitution() != null &&
					 * user.getInstitution().getId() != null) {//
					 * 查看session中登录用户的机构订阅信息 condition.put("level", 2);
					 * condition.put("isTrail", "0");
					 * condition.put("institutionId",
					 * user.getInstitution().getId()); list =
					 * this.customService.getLicenseList(condition,
					 * "order by a.createdon desc "); }
					 */
				}

				// 输出的excel文件工作表名
				String worksheet = "mySubscriptionLog";
				// excel工作表的标题
				String[] title = { "Title", "Author", "PubDate", "Price", "Code", "Remark", "Create Date", "Type", "Begin", "End" };

				WritableWorkbook workbook;
				OutputStream os = response.getOutputStream();
				response.reset();// 清空输出流
				response.setHeader("Content-disposition", "attachment; filename=mySubscription.xls");// 设定输出文件头
				response.setContentType("application/vnd.ms-excel;charset=UTF-8");// 定义输出类型

				workbook = Workbook.createWorkbook(os);

				WritableSheet sheet = workbook.createSheet(worksheet, 0);

				for (int i = 0; i < title.length; i++) {
					// Label(列号,行号 ,内容 )
					sheet.addCell(new Label(i, 0, title[i]));
				}

				int row = 1;
				for (LLicense l : list) {
					if (l.getPublications() != null) {
						sheet.addCell(new Label(0, row, l.getPublications().getTitle()));
						sheet.addCell(new Label(1, row, l.getPublications().getAuthor()));
						if (form.getSearchType() != null && form.getSearchType() == 3) {
							sheet.addCell(new Label(2, row, l.getPublications().getCreateDate()));
						} else {
							sheet.addCell(new Label(2, row, l.getPublications().getPubDate()));
						}
						sheet.addCell(new Label(3, row, l.getPublications().getListPrice() == null ? "N/A" : l.getPublications().getListPrice().toString()));
						sheet.addCell(new Label(4, row, l.getPublications().getCode()));
						sheet.addCell(new Label(5, row, l.getPublications().getRemark()));
						sheet.addCell(new Label(6, row, DateUtil.getNowDate("yyyy-MM-dd", l.getCreatedon())));
						if (l.getType() == 1) {
							sheet.addCell(new Label(7, row, Lang.getLanguage("Pages.User.Subscription.Table.Label.type1", request.getSession().getAttribute("lang").toString())));
							sheet.addCell(new Label(8, row, "N/A"));
							sheet.addCell(new Label(9, row, "N/A"));
						} else {
							if (l.getIsTrial() == 1) {
								sheet.addCell(new Label(7, row, Lang.getLanguage("Pages.User.Subscription.Lable.Trial", request.getSession().getAttribute("lang").toString())));
							} else {
								sheet.addCell(new Label(7, row, Lang.getLanguage("Pages.User.Subscription.Table.Label.type2", request.getSession().getAttribute("lang").toString())));
							}
							sheet.addCell(new Label(8, row, DateUtil.getNowDate("yyyy-MM-dd", l.getStartTime())));
							sheet.addCell(new Label(9, row, l.getEndTime() == null ? "N/A" : DateUtil.getNowDate("yyyy-MM-dd", l.getEndTime())));
						}
					} else {
						// 产品包
						sheet.addCell(new Label(0, row, l.getCollection().getName()));
						sheet.addCell(new Label(1, row, ""));
						sheet.addCell(new Label(2, row, DateUtil.getNowDate("yyyy-MM-dd", l.getCollection().getCreateOn())));
						sheet.addCell(new Label(3, row, l.getCollection().getPrice() == null ? "N/A" : l.getCollection().getPrice().toString()));
						sheet.addCell(new Label(4, row, l.getCollection().getCode()));
						sheet.addCell(new Label(5, row, l.getCollection().getDesc()));
						sheet.addCell(new Label(6, row, DateUtil.getNowDate("yyyy-MM-dd", l.getCreatedon())));
						if (l.getType() == 1) {
							sheet.addCell(new Label(7, row, Lang.getLanguage("Pages.User.Subscription.Table.Label.type1", request.getSession().getAttribute("lang").toString())));
							sheet.addCell(new Label(8, row, "N/A"));
							sheet.addCell(new Label(9, row, "N/A"));
						} else {
							sheet.addCell(new Label(7, row, Lang.getLanguage("Pages.User.Subscription.Table.Label.type2", request.getSession().getAttribute("lang").toString())));
							sheet.addCell(new Label(8, row, DateUtil.getNowDate("yyyy-MM-dd", l.getStartTime())));
							sheet.addCell(new Label(9, row, l.getEndTime() == null ? "N/A" : DateUtil.getNowDate("yyyy-MM-dd", l.getEndTime())));
						}
					}
					row++;
				}

				workbook.write();
				workbook.close();
				os.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
