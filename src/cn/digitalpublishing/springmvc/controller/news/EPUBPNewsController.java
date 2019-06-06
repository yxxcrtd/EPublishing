package cn.digitalpublishing.springmvc.controller.news;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.com.daxtech.framework.Internationalization.Lang;
import cn.com.daxtech.framework.exception.CcsException;
import cn.digitalpublishing.ep.po.PNews;
import cn.digitalpublishing.springmvc.controller.BaseController;
import cn.digitalpublishing.springmvc.form.news.NewsForm;

/**
 * 新闻
 * 
 * @author LiuYe
 * 
 */

@Controller
@RequestMapping("/pages/news")
public class EPUBPNewsController extends BaseController {

	/**
	 * 显示首页上的10条新闻
	 * 
	 * @param request
	 * @param response
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/form/listForIndex")
	public ModelAndView listForIndex(HttpServletRequest request, NewsForm form) throws Exception {
		String forwardString = "news/newsforindex";
//		String forwardString = "news/NewsForIndex.ftl";
		Map<String, Object> condition = new HashMap<String, Object>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<PNews> list = new ArrayList<PNews>();
		try {
			form.setUrl(request.getRequestURL().toString());
			form.setCount(this.newsService.getCount(condition));
			list = this.newsService.getPagingList(condition, " order by a.createDate desc ", form.getPageCount(), form.getCurpage());
			model.put("list", list);
			model.put("form", form);
		} catch (Exception e) {
			request.setAttribute("message", (e instanceof CcsException) ? Lang.getLanguage(((CcsException) e).getPrompt(), request.getSession().getAttribute("lang").toString()) : e.getMessage());
			forwardString = "error";
		}
		return new ModelAndView(forwardString, model);
	}
	
	/**
	 * 查询新闻列表
	 * 
	 * @param request
	 * @param response
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/form/list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, NewsForm form) throws Exception {
		String forwardString = "news/leftList";
		Map<String, Object> condition = new HashMap<String, Object>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<PNews> list = new ArrayList<PNews>();
		PNews reNew = new PNews();
		try {
			form.setUrl(request.getRequestURL().toString());
			form.setCount(this.newsService.getCount(condition));
			list = this.newsService.getPagingList(condition, "", form.getPageCount(), form.getCurpage());
			// 由于初始化页面时 是在index页面点击进入 故第一位放置为被点击新闻
			if (form.getNewsId() != null && !form.getNewsId().equals("")) {
				PNews obj = this.newsService.getById(form.getNewsId());
				for (int i = 0; i < list.size(); i++) {
					if (list.get(i).getId().equals(obj.getId())) {
						reNew = list.get(0);
						list.set(0, list.get(i));
						list.set(i, reNew);
						break;
					}
				}
				list.set(0, obj);
			}
			model.put("list", list);
			model.put("form", form);
		} catch (Exception e) {
			request.setAttribute("message", (e instanceof CcsException) ? Lang.getLanguage(((CcsException) e).getPrompt(), request.getSession().getAttribute("lang").toString()) : e.getMessage());
			forwardString = "error";
		}
		return new ModelAndView(forwardString, model);
	}

	/**
	 * 查询新闻列表
	 * 
	 * @param request
	 * @param response
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/form/newsList")
	public ModelAndView newsList(HttpServletRequest request, HttpServletResponse response, NewsForm form) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		String forwardString = "news/newslist";
		/*
		 * Map<String,Object> condition = new HashMap<String,Object>();
		 * List<PNews> list=new ArrayList<PNews>();
		 */
		try {
			/*
			 * form.setUrl(request.getRequestURL().toString()); String
			 * id=form.getNewsId(); PNews obj=this.newsService.getById(id);
			 * form.setCount(this.newsService.getCount(condition));
			 * list=this.newsService.getPagingList(condition,
			 * " order by a.createDate desc ", form.getPageCount(),
			 * form.getCurpage()); list.set(0, obj); model.put("list", list);
			 */
			model.put("form", form);
		} catch (Exception e) {
			request.setAttribute("message", (e instanceof CcsException) ? Lang.getLanguage(((CcsException) e).getPrompt(), request.getSession().getAttribute("lang").toString()) : e.getMessage());
			forwardString = "error";
		}
		return new ModelAndView(forwardString, model);
	}

	@RequestMapping(value = "/form/forNewsList")
	public ModelAndView forNewsList(HttpServletRequest request, HttpServletResponse response, NewsForm form) throws Exception {
		String forwardString = "news/fornewslist";
		Map<String, Object> model = new HashMap<String, Object>();
		try {
			form.setUrl(request.getRequestURL().toString());
			PNews obj = this.newsService.getById(form.getNewsId());
			model.put("obj", obj);
			model.put("form", form);
		} catch (Exception e) {
			request.setAttribute("message", (e instanceof CcsException) ? Lang.getLanguage(((CcsException) e).getPrompt(), request.getSession().getAttribute("lang").toString()) : e.getMessage());
			forwardString = "error";
		}
		return new ModelAndView(forwardString, model);
	}

	/**
	 * （新增|修改）保存
	 * 
	 * @param form
	 * @param response
	 * @param request
	 *            request
	 */
	@RequestMapping(value = "/form/edit")
	public ModelAndView edit(HttpServletRequest request, HttpServletResponse response, NewsForm form) throws Exception {
		String forwardString = "news/edit";
		Map<String, Object> model = new HashMap<String, Object>();
		PNews obj = new PNews();
		try {
			if (form.getId() != null && !form.getId().equals("")) {
				obj = this.newsService.getById(form.getId());
				DateFormat dateFmt = new SimpleDateFormat("yyyy-MM-dd");
				form.setCreateDate(dateFmt.format(obj.getCreateDate()));
			}
			model.put("obj", obj);
			model.put("form", form);
		} catch (Exception e) {
			form.setMsg((e instanceof CcsException) ? ((CcsException) e).getMessage() : e.getMessage());
		}
		return new ModelAndView(forwardString, model);
	}

	/**
	 * （新增|修改）保存
	 * 
	 * @param form
	 * @param response
	 * @param request
	 *            request
	 */
	@RequestMapping(value = "/form/save")
	public ModelAndView picDelete(HttpServletRequest request, HttpServletResponse response, NewsForm form) throws Exception {
		PNews obj = form.getObj();
		try {
			DateFormat dateFmt = new SimpleDateFormat("yyyy-MM-dd");
			obj.setCreateDate(dateFmt.parse(form.getCreateDate()));
			if (form.getId() != null && !form.getId().equals("")) {
				this.newsService.update(obj, form.getId(), null);
				// this.newsService.syncToEPUB(form.getId());
			} else {
				/*
				 * String a=""; for (int i = 0; i < 100000; i++) {
				 * System.out.println(i); a+=i+"哈哈*"; } obj.setContent(a);
				 */
				this.newsService.insert(obj);
				// this.newsService.syncToEPUB(obj.getId());
			}
			form.setMsg(form.getId() != null && !form.getId().equals("") ? "修改新闻信息成功" : "新增新闻信息成功");

		} catch (Exception e) {
			form.setMsg((e instanceof CcsException) ? ((CcsException) e).getMessage() : e.getMessage());
		}
		return this.list(request, response, form);
	}

	/**
	 * 删除新闻
	 * 
	 * @param form
	 * @param response
	 * @param request
	 *            request
	 */
	@RequestMapping(value = "/form/delete")
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response, NewsForm form) throws Exception {
		try {
			this.newsService.delete(form.getId());
			// this.newsService.syncToEPUB(form.getId());
			form.setMsg("删除新闻信息成功");

		} catch (Exception e) {
			form.setMsg((e instanceof CcsException) ? ((CcsException) e).getMessage() : e.getMessage());
		}
		return this.list(request, response, form);
	}
	
}
