package cn.digitalpublishing.springmvc.controller;

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.servlet.ModelAndView;

import cn.com.daxtech.framework.Internationalization.Lang;
import cn.com.daxtech.framework.exception.CcsException;
import cn.com.daxtech.framework.model.Param;
import cn.com.daxtech.framework.util.ObjectUtil;
import cn.com.daxtech.framework.util.StringUtil;
import cn.digitalpublishing.ep.po.BPublisher;
import cn.digitalpublishing.ep.po.CUser;
import cn.digitalpublishing.ep.po.LAccess;
import cn.digitalpublishing.ep.po.PEpubAnnotation;
import cn.digitalpublishing.ep.po.PEpubBookmark;
import cn.digitalpublishing.ep.po.PPage;
import cn.digitalpublishing.ep.po.PPublications;
import cn.digitalpublishing.springmvc.form.ViewForm;
import cn.digitalpublishing.springmvc.form.product.EpubForm;
import cn.digitalpublishing.springmvc.form.product.PPublicationsForm;
import cn.digitalpublishing.util.io.FileUtil;
import cn.digitalpublishing.util.web.DateUtil;
import cn.digitalpublishing.util.web.IpUtil;
import cn.digitalpublishing.util.web.JSONUtil;

import com.alipay.util.httpClient.HttpRequest;
import com.zhima.server.model.ResultObject;
import com.zhima.server.util.restful.Converter;

@Controller
@RequestMapping("/pages/epub")
public class EpubController extends BaseController {

	@RequestMapping(value = "/form/search")
	public void search(HttpServletRequest request, HttpServletResponse response, HttpSession session, ViewForm form) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id = form.getId();
			map = this.pagesIndexService.selectPagesByFullText(id, form.getValue(), form.getCurpage(), form.getPageCount());
			List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
			if (map.get("count") != null && ((Long) map.get("count")) > 0) {
				List<Map<String, Object>> result = (List<Map<String, Object>>) map.get("result");
				Map<String, Object> finish = new HashMap<String, Object>();
				for (int i = 0; i < result.size(); i++) {
					String pageId = result.get(i).get("id").toString();
					PPage pg = this.pPublicationsService.getPages(pageId);
					if (pg != null) {
						String pn = pg.getMark().split("#")[0];
						if (!finish.containsKey(pn)) {
							finish.put(pn, 1);
						} else {
							Integer count = (Integer) finish.get(pn);
							finish.put(pn, count + 1);
						}
					}
				}
				if (!finish.isEmpty()) {
					for (String key : finish.keySet()) {
						Map<String, Object> sr = new HashMap<String, Object>();
						sr.put("pageNumber", key);
						sr.put("hitCount", finish.get(key).toString());
						results.add(sr);
					}
				}
			}
			map.put("results", results);
			String str = form.getValue();
			str = URLDecoder.decode(str, "utf-8");
			map.put("qValue", form.getValue());
		} catch (Exception e) {
			throw e;
		}
		try {
			JSONArray json = new JSONArray();
			json.add(map);
			response.setContentType("text/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(json.toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			throw e;
			// request.setAttribute("message",(e instanceof
			// CcsException)?Lang.getLanguage(((CcsException)e).getPrompt(),request.getSession().getAttribute("lang").toString()):e.getMessage());
		}
	}

	/**
	 * 数据接口
	 * 
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/unzipEpub", method = RequestMethod.POST)
	public void unzipEpub(HttpServletRequest request, Model model) {
		ResultObject<PPublications> result = null;
		try {
			String objJson = request.getParameter("obj").toString();
			String webRoot = request.getSession().getServletContext().getRealPath("");// 网站根目录
			String basePath = Param.getParam("pdf.directory.config").get("dir").replace("-", ":");// 文件根目录

			Converter<PPublications> converter = new Converter<PPublications>();
			PPublications obj = (PPublications) converter.json2Object(objJson, PPublications.class.getName());
			Boolean flag = false;
			System.out.println("unzip:" + basePath + obj.getPdf());
			System.out.println("to:" + webRoot + obj.getEpubDir());
			if (FileUtil.isExist(basePath + obj.getPdf())) {
				FileUtil.unZip(basePath + obj.getPdf(), webRoot + obj.getEpubDir());
				flag = true;
			}

			ObjectUtil<PPublications> util = new ObjectUtil<PPublications>();
			obj = util.setNull(obj, new String[] { Set.class.getName(), List.class.getName() });

			if (obj.getPublications() != null) {
				util.setNull(obj.getPublications(), new String[] { Set.class.getName(), List.class.getName() });
			}
			if (obj.getVolume() != null) {
				util.setNull(obj.getVolume(), new String[] { Set.class.getName(), List.class.getName() });
			}
			if (obj.getIssue() != null) {
				util.setNull(obj.getIssue(), new String[] { Set.class.getName(), List.class.getName() });
			}
			if (obj.getPublisher() != null) {
				ObjectUtil<BPublisher> util2 = new ObjectUtil<BPublisher>();
				util2.setNull(obj.getPublisher(), new String[] { Set.class.getName(), List.class.getName() });
			}
			if (flag) {
				result = new ResultObject<PPublications>(1, obj, Lang.getLanguage("Controller.Publications.Rest.Maintain.Succ", request.getSession().getAttribute("lang").toString()));// "出版商信息维护成功！");
			} else {
				result = new ResultObject<PPublications>(2, Lang.getLanguage("Controller.Publications.Rest.Maintain.Failed", request.getSession().getAttribute("lang").toString()));
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResultObject<PPublications>(2, (e instanceof CcsException) ? Lang.getLanguage(((CcsException) e).getPrompt(), request.getSession().getAttribute("lang").toString()) : Lang.getLanguage("Controller.Publications.Rest.Maintain.Failed", request.getSession()
					.getAttribute("lang").toString()));// "出版商信息维护失败！");
		}
		model.addAttribute("target", result);
	}

	@RequestMapping("/getdata")
	public void getData(HttpServletRequest request, HttpServletResponse response, PPublicationsForm form) throws Exception {
		try {
			String json = "";
			if (form.getId() != null && !"".equals(form.getId())) {
				PPublications pub = this.pPublicationsService.getPublications(form.getId());
				// 出版物、可用、文件类型为epub
				if (pub != null && pub.getAvailable() != 3 && pub.getFileType() == 2 && null!=pub.getEpubPath() && !"".equals(pub.getEpubPath())) {
					if (pub.getEpubPath().trim().toLowerCase().endsWith(".epub")) {
						//String jFile = pub.getPdf().trim().replaceFirst("(?i)\\.epub", ".json");
						String jFile = pub.getEpubPath().trim().replaceFirst("(?i)\\.epub", ".json");
						String bPath = Param.getParam("pdf.directory.config").get("dir").replace('-', ':');
						if (FileUtil.isExist(bPath + jFile)) {
							json = FileUtil.readFileAsString(bPath + jFile, "UTF-8");
							if (json != null && !"".equals(json)) {
								json = "{\"is_gift\":0,\"fixed_price\":\"" + pub.getListPrice().toString() + "\",\"has_formula\":0,\"title\":" + JSONUtil.string2Json(pub.getTitle())
										+ ",\"price\":\"60.00\",\"purchase_time\":1413891387,\"promotion_remark\":\"\",\"is_sample\":1,\"cover_url\":\"http:\\/\\/img3.douban.com\\/view\\/ark_article_cover\\/ipad\\/public\\/6064515.jpg?v=1412996136.0\",\"data\":" + json;
								json += ",\"has_added\":0}";
							}
						}
					}

				}
			}
			//response.setContentType("application/json;charset=UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
			out.close();
		} catch (Exception e) {
			throw e;
			// request.setAttribute("message",(e instanceof
			// CcsException)?Lang.getLanguage(((CcsException)e).getPrompt(),request.getSession().getAttribute("lang").toString()):e.getMessage());
		}
	}

	@RequestMapping("/ebook/{pubId}")
	public ModelAndView read(@PathVariable String pubId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String forwardString = "epub/reader";
		Map<String, Object> model = new HashMap<String, Object>();
		try {
			model.put("pubId", pubId);

			// 统计
			CUser user = (null == request.getSession().getAttribute("mainUser")) ? null : (CUser) request.getSession().getAttribute("mainUser");
			this.addLog(pubId, user, null == user ? null : user.getInstitution().getId(), IpUtil.getIp(request), request);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", (e instanceof CcsException) ? Lang.getLanguage(((CcsException) e).getPrompt(), request.getSession().getAttribute("lang").toString()) : e.getMessage());
			forwardString = "error";
		}
		return new ModelAndView(forwardString, model);
	}

	@RequestMapping("/reader")
	public ModelAndView ieread(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String forwardString = "epub/iereader";
		return new ModelAndView(forwardString);
	}

	@RequestMapping("/piwik")
	public void piwik(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.print("");
		out.flush();
		out.close();

	}

	@RequestMapping("/ebook/undefinedreader_login_signup")
	public void undefinedreader_login_signup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.print("");
		out.flush();
		out.close();

	}

	@RequestMapping("/reviews/{pubId}")
	public void n_reviews(@PathVariable String pubId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.print("1");
		out.flush();
		out.close();

	}

	@RequestMapping("/checkNew")
	public void need_update(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		response.setContentType("text/json;charset=utf-8");
		out.print("{\"r\":0}");
		out.flush();
		out.close();

	}

	@RequestMapping("/j/currtime")
	public void currtime(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.print("1415087704");
		out.flush();
		out.close();

	}

	@RequestMapping("/progress/")
	public void progress(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		if ("POST".equals(request.getMethod())) {
			out.print("{\"r\":0}");
		} else {
			out.print("{ \"progress\": { \"paragraph_offset\": 0, \"part_sequence\": 0, \"part_paragraph_sequence\": 30, \"paragraph_id\": \"id364256_100000\" }, \"r\": 0 }");
		}
		out.flush();
		out.close();

	}

	@RequestMapping("/j/article_v2/6064515/annotations_by_paragraphs")
	public void annotations_by_paragraphs(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.print("[]");
		out.flush();
		out.close();

	}

	@RequestMapping("/j/article_v2/6064515/my_annotations")
	public void my_annotations(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.print("[ { \"extra\": { \"text\": \"本书中用到了dwarves和dwarvish这两种\", \"percent\": \"0.02\" }, \"endOffset\": 139, \"visible_private\": \"\", \"middleContainers\": [ ], \"note\": \"\", \"n_comments\": 0, \"create_time\": \"2014-10-23T15:31:17+08:00\", \"startOffset\": 115, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65088006, \"startContainerId\": 65088006, \"n_favorites\": 0, \"type\": \"underline\", \"id\": \"4534817\", \"tags\": [ \"mine\" ] }, { \"extra\": { \"text\": \"远的故事，那时候的语言和文字与我们今日所使用的有着很大的不同。书中是用英语来代替那些古老语言的，\", \"percent\": \"0.02\" }, \"endOffset\": 54, \"visible_private\": \"\", \"middleContainers\": [ ], \"note\": \"\", \"n_comments\": 0, \"create_time\": \"2014-10-24T11:12:08+08:00\", \"startOffset\": 7, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65088006, \"startContainerId\": 65088006, \"n_favorites\": 0, \"type\": \"underline\", \"id\": \"4541586\", \"tags\": [ \"mine\" ] }, { \"extra\": { \"text\": \"）一词惟一正确的复数形式是dwarfs，其\", \"percent\": \"0.02\" }, \"endOffset\": 99, \"visible_private\": \"\", \"middleContainers\": [ ], \"note\": \"\", \"n_comments\": 0, \"create_time\": \"2014-10-24T11:12:11+08:00\", \"startOffset\": 79, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65088006, \"startContainerId\": 65088006, \"n_favorites\": 0, \"type\": \"underline\", \"id\": \"4541587\", \"tags\": [ \"mine\" ] }, { \"extra\": { \"text\": \"到。 他慢\", \"percent\": \"3.74\" }, \"endOffset\": 1, \"visible_private\": \"on\", \"middleContainers\": [ ], \"note\": \"111\", \"n_comments\": 0, \"create_time\": \"2014-10-28T19:05:12+08:00\", \"startOffset\": 95, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65088515, \"startContainerId\": 65088514, \"n_favorites\": 0, \"type\": \"note\", \"id\": \"4581341\", \"tags\": [ \"mine\" ] }, { \"extra\": { \"text\": \"地四下摸索着，直到\", \"percent\": \"3.74\" }, \"endOffset\": 21, \"visible_private\": \"\", \"middleContainers\": [ ], \"note\": \"\", \"n_comments\": 0, \"create_time\": \"2014-10-28T19:10:42+08:00\", \"startOffset\": 13, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65088515, \"startContainerId\": 65088515, \"n_favorites\": 0, \"type\": \"underline\", \"id\": \"4581391\", \"tags\": [ \"mine\" ] }, { \"extra\": { \"text\": \"了水里！“不够远！”比尔博\", \"percent\": \"7.62\" }, \"endOffset\": 22, \"visible_private\": \"on\", \"middleContainers\": [ ], \"note\": \"11111111111\", \"n_comments\": 0, \"create_time\": \"2014-10-30T20:17:42+08:00\", \"startOffset\": 10, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65089052, \"startContainerId\": 65089052, \"n_favorites\": 0, \"type\": \"note\", \"id\": \"4603786\", \"tags\": [ \"mine\" ] } ]");
		out.flush();
		out.close();
	}

	@RequestMapping("/j/article_v2/6064515/my_searchs")
	public void my_searchs(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.print("[ { \"extra\": { \"text\": \"本书中用到了dwarves和dwarvish这两种\", \"percent\": \"0.02\" }, \"endOffset\": 139, \"visible_private\": \"\", \"middleContainers\": [ ], \"note\": \"\", \"n_comments\": 0, \"create_time\": \"2014-10-23T15:31:17+08:00\", \"startOffset\": 115, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65088006, \"startContainerId\": 65088006, \"n_favorites\": 0, \"type\": \"underline\", \"id\": \"4534817\", \"tags\": [ \"mine\" ] }, { \"extra\": { \"text\": \"远的故事，那时候的语言和文字与我们今日所使用的有着很大的不同。书中是用英语来代替那些古老语言的，\", \"percent\": \"0.02\" }, \"endOffset\": 54, \"visible_private\": \"\", \"middleContainers\": [ ], \"note\": \"\", \"n_comments\": 0, \"create_time\": \"2014-10-24T11:12:08+08:00\", \"startOffset\": 7, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65088006, \"startContainerId\": 65088006, \"n_favorites\": 0, \"type\": \"underline\", \"id\": \"4541586\", \"tags\": [ \"mine\" ] }, { \"extra\": { \"text\": \"）一词惟一正确的复数形式是dwarfs，其\", \"percent\": \"0.02\" }, \"endOffset\": 99, \"visible_private\": \"\", \"middleContainers\": [ ], \"note\": \"\", \"n_comments\": 0, \"create_time\": \"2014-10-24T11:12:11+08:00\", \"startOffset\": 79, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65088006, \"startContainerId\": 65088006, \"n_favorites\": 0, \"type\": \"underline\", \"id\": \"4541587\", \"tags\": [ \"mine\" ] }, { \"extra\": { \"text\": \"到。 他慢\", \"percent\": \"3.74\" }, \"endOffset\": 1, \"visible_private\": \"on\", \"middleContainers\": [ ], \"note\": \"111\", \"n_comments\": 0, \"create_time\": \"2014-10-28T19:05:12+08:00\", \"startOffset\": 95, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65088515, \"startContainerId\": 65088514, \"n_favorites\": 0, \"type\": \"note\", \"id\": \"4581341\", \"tags\": [ \"mine\" ] }, { \"extra\": { \"text\": \"地四下摸索着，直到\", \"percent\": \"3.74\" }, \"endOffset\": 21, \"visible_private\": \"\", \"middleContainers\": [ ], \"note\": \"\", \"n_comments\": 0, \"create_time\": \"2014-10-28T19:10:42+08:00\", \"startOffset\": 13, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65088515, \"startContainerId\": 65088515, \"n_favorites\": 0, \"type\": \"underline\", \"id\": \"4581391\", \"tags\": [ \"mine\" ] }, { \"extra\": { \"text\": \"了水里！“不够远！”比尔博\", \"percent\": \"7.62\" }, \"endOffset\": 22, \"visible_private\": \"on\", \"middleContainers\": [ ], \"note\": \"11111111111\", \"n_comments\": 0, \"create_time\": \"2014-10-30T20:17:42+08:00\", \"startOffset\": 10, \"owner\": { \"url\": \"http://www.douban.com/people/103726057/\", \"user_id\": \"103726057\", \"avatar\": \"http://img3.douban.com/pics/icon/user_icon.jpg\", \"name\": \"jack\" }, \"endContainerId\": 65089052, \"startContainerId\": 65089052, \"n_favorites\": 0, \"type\": \"note\", \"id\": \"4603786\", \"tags\": [ \"mine\" ] } ]");
		out.flush();
		out.close();
	}

	@RequestMapping("/j/share/check_sina")
	public void check_sina(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.print("{\"bind\":false}");
		out.flush();
		out.close();

	}

	@RequestMapping("/j/share/annotations")
	public void annotations(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.print("{\"r\":0,\"id\":\"4641688\"}");
		out.flush();
		out.close();

	}

	@RequestMapping("/bookmark/create")
	public void createMark(HttpServletRequest request, HttpServletResponse response, EpubForm form) throws Exception {
		try {
			CUser user = (CUser) request.getSession().getAttribute("mainUser");
			if (user != null) {
				PEpubBookmark mark = new PEpubBookmark();
				mark.setParagraphId(form.getParagraph_id());
				mark.setParagraphOffset(form.getParagraph_offset());
				mark.setPartSequence(Integer.parseInt(mark.getParagraphId().substring(0, mark.getParagraphId().length() - 7)));
				mark.setPartParagraphSequence(Integer.parseInt(mark.getParagraphId().substring(mark.getParagraphId().length() - 7)));
				mark.setUser(user);
				mark.setCreateOn(new Date());
				mark.setMarkContext("…" + form.getMarkContext() + "…");
				mark.setPublications(new PPublications());
				mark.getPublications().setId(form.getWorks_id());
				this.pRecordService.saveEBMark(mark);
				PrintWriter out = response.getWriter();
				out.print(getBookMarkJSON(mark));
				out.flush();
				out.close();
			}
		} catch (Exception e) {

		}
	}

	@RequestMapping("/{pubId}/annotation")
	public void createAnno(@PathVariable String pubId, HttpServletRequest request, HttpServletResponse response, EpubForm form) throws Exception {
		try {
			CUser user = (CUser) request.getSession().getAttribute("mainUser");

			if (user != null) {
				if ("POST".equals(request.getMethod())) {// 创建笔记或划线
					if (form.getAnnotation() != null) {
						JSONObject json = JSONObject.fromObject(form.getAnnotation());

						PEpubAnnotation anno = new PEpubAnnotation();
						anno.setCreateOn(new Date());
						anno.setEndContainerId(json.get("endContainerId").toString());
						anno.setEndOffset((Integer) json.get("endOffset"));
						JSONArray mcArr = (JSONArray) json.get("middleContainers");
						anno.setMiddleContainers(mcArr != null && mcArr.size() > 0 ? mcArr.join(",").replace("\"\"", "\"") : "");
						anno.setNote(json.get("note") == null ? "" : json.get("note").toString());
						anno.setText(json.get("selectionText") == null ? "" : json.get("selectionText").toString());
						anno.setPublications(new PPublications());
						anno.getPublications().setId(pubId);
						anno.setStartContainerId(json.get("startContainerId").toString());
						anno.setStartOffset((Integer) json.get("startOffset"));
						anno.setType(json.get("type").toString());
						anno.setUser(user);
						anno.setVisiblePrivate(json.get("visible_private").toString());
						this.pNoteService.saveAnnotation(anno);
						PrintWriter out = response.getWriter();
						out.print("{\"r\":0,\"id\":\"" + anno.getId() + "\"}");
						out.flush();
						out.close();
					}
				} else if ("DELETE".equals(request.getMethod())) {// 删除笔记或划线

					StringBuffer jb = new StringBuffer();
					String line = null;
					try {
						BufferedReader reader = request.getReader();
						while ((line = reader.readLine()) != null)
							jb.append(line);
					} catch (Exception e) { /* report an error */
					}
					String postdata = jb.toString();
					if (postdata != null && postdata.length() > 0) {
						this.pNoteService.delEBAnno(postdata.replace("id=", ""));
					}
					PrintWriter out = response.getWriter();
					out.print("{\"r\":0}");
					out.flush();
					out.close();
				} else if ("PUT".equals(request.getMethod())) {// 更新笔记或划线
					StringBuffer jb = new StringBuffer();
					String line = null;
					try {
						BufferedReader reader = request.getReader();
						while ((line = reader.readLine()) != null)
							jb.append(line);
					} catch (Exception e) { /* report an error */
					}
					String postdata = jb.toString();
					postdata = URLDecoder.decode(postdata, "utf-8");
					postdata = postdata.replace("annotation=", "");
					JSONObject json = JSONObject.fromObject(postdata);

					PEpubAnnotation anno = new PEpubAnnotation();
					anno.setCreateOn(new Date());
					anno.setNote(json.get("note") == null ? "" : json.get("note").toString());
					anno.setId(json.get("id").toString());
					this.pNoteService.updateEBAnno(anno);
					PrintWriter out = response.getWriter();
					out.print("{\"r\":0}");
					out.flush();
					out.close();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			PrintWriter out = response.getWriter();
			out.print("{\"r\":0}");
			out.flush();
			out.close();
		}

	}

	@RequestMapping("/bookmark/delete/{markId}")
	public void deleteMark(@PathVariable String markId, HttpServletRequest request, HttpServletResponse response, EpubForm form) throws Exception {
		try {
			CUser user = (CUser) request.getSession().getAttribute("mainUser");
			if (user != null) {
				System.out.println(markId);
				this.pRecordService.delEBMarks(markId);
				response.setContentType("text/json;charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("{\"r\":0}");
				out.flush();
				out.close();
			}
		} catch (Exception e) {

		}

	}

	@RequestMapping("/bookmark/getMarks")
	public void getMarks(HttpServletRequest request, HttpServletResponse response) throws Exception {
		CUser user = (CUser) request.getSession().getAttribute("mainUser");
		StringBuffer buff = new StringBuffer();
		buff.append("[");
		if (user != null) {
			String pubId = request.getParameter("pubId");
			if (pubId != null && !"".equals(pubId)) {
				Map<String, Object> condition = new HashMap<String, Object>();
				condition.put("pubId", pubId);
				condition.put("userId", user.getId());
				List<PEpubBookmark> list = this.pRecordService.getEBMarks(condition, " order by a.paragraphId ");

				if (list != null && list.size() > 0) {
					for (PEpubBookmark mark : list) {
						if (buff.length() > 1) {
							buff.append(",");
						}
						buff.append(getBookMarkJSON(mark));
					}
				}

			}
		} else {
			PEpubBookmark m = new PEpubBookmark();
			m.setId("0");
			buff.append(getBookMarkJSON(m));
		}
		buff.append("]");
		response.setContentType("text/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(buff.toString());
		out.flush();
		out.close();
	}

	@RequestMapping("/{pubId}/getAnnosByParas")
	public void getAnnos(@PathVariable String pubId, HttpServletRequest request, HttpServletResponse response, EpubForm form) throws Exception {
		CUser user = (CUser) request.getSession().getAttribute("mainUser");
		if (user != null && form.getParagraph_ids() != null && !"".equals(form.getParagraph_ids())) {
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("pubId", pubId);
			condition.put("userId", user.getId());
			condition.put("paraIds", form.getParagraph_ids());
			List<PEpubAnnotation> list = this.pNoteService.getEBAnnos(condition, "");
			StringBuffer buff = new StringBuffer();
			buff.append("[");
			if (list != null && list.size() > 0) {
				for (PEpubAnnotation anno : list) {
					if (buff.length() > 1) {
						buff.append(",");
					}
					buff.append(getAnnoJSON(anno));
				}
			}
			buff.append("]");
			System.out.println(buff.toString());
			response.setContentType("text/json;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(buff.toString());
			out.flush();
			out.close();

		}
	}

	@RequestMapping("/{pubId}/getMyAnnos")
	public void getMyAnnos(@PathVariable String pubId, HttpServletRequest request, HttpServletResponse response, EpubForm form) throws Exception {
		CUser user = (CUser) request.getSession().getAttribute("mainUser");
		StringBuffer buff = new StringBuffer();
		buff.append("[");
		if (user != null) {
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("pubId", pubId);
			condition.put("userId", user.getId());
			List<PEpubAnnotation> list = this.pNoteService.getEBAnnos(condition, "");

			if (list != null && list.size() > 0) {
				for (PEpubAnnotation anno : list) {
					if (buff.length() > 1) {
						buff.append(",");
					}
					buff.append(getAnnoJSONForList(anno));
				}
			}
		} else {
			PEpubAnnotation anno = new PEpubAnnotation();
			anno.setId("0");
			buff.append(getAnnoJSONForList(anno));
		}
		buff.append("]");
		System.out.println(buff.toString());
		response.setContentType("text/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(buff.toString());
		out.flush();
		out.close();
	}

	@RequestMapping("/j/article_v2/6064515/annotation")
	public void annotation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.print("{\"r\":0,\"id\":\"4739277\"}");
		out.flush();
		out.close();

	}

	private String getBookMarkJSON(PEpubBookmark mark) {
		StringBuffer buff = new StringBuffer();
		buff.append("{\"paragraph_offset\": ");
		buff.append(mark.getParagraphOffset() != null ? mark.getParagraphOffset() : "0");
		buff.append(",\"update_time\":\"");
		buff.append(mark.getCreateOn() != null ? DateUtil.getNowDate("yyyy-MM-dd hh:mm:ss", mark.getCreateOn()) : "");
		buff.append("\",\"paragraph_id\":\"");
		buff.append(mark.getParagraphId());
		buff.append("\",\"part_sequence\":");
		buff.append(mark.getPartSequence() != null ? mark.getPartSequence() : "0");
		buff.append(",\"abstract\":");
		buff.append(mark.getMarkContext() != null ? JSONUtil.string2Json(mark.getMarkContext()) : "\"\"");
		buff.append(",\"part_paragraph_sequence\":");
		buff.append(mark.getPartParagraphSequence() != null ? mark.getPartParagraphSequence() : "\"\"");
		buff.append(",\"percent\":\"0\"");
		buff.append(",\"id\":\"");
		buff.append(mark.getId());
		buff.append("\",\"works_id\":\"");
		buff.append(mark.getPublications() != null ? mark.getPublications().getId() : "");
		buff.append("\"}");
		return buff.toString();
	}

	private String getAnnoJSON(PEpubAnnotation anno) {
		StringBuffer buff = new StringBuffer();
		buff.append("{\"endOffset\": ");
		buff.append(anno.getEndOffset() == null ? 0 : anno.getEndOffset());
		buff.append(",\"visible_private\":\"");
		buff.append(anno.getVisiblePrivate() == null ? "" : anno.getVisiblePrivate());
		buff.append("\",\"middleContainers\":[");
		buff.append(anno.getMiddleContainers() == null ? "" : anno.getMiddleContainers());
		buff.append("],\"note\":");
		buff.append(anno.getNote() != null ? JSONUtil.string2Json(anno.getNote()) : "");
		buff.append(",\"n_comments\":0");
		buff.append(",\"create_time\":\"");
		buff.append(DateUtil.getNowDate("yyyy-MM-dd hh:mm:ss", anno.getCreateOn()).replace(' ', 'T') + "+08:00");
		buff.append("\",\"startOffset\":");
		buff.append(anno.getStartOffset() == null ? 0 : anno.getStartOffset());
		if (anno.getUser() != null) {
			buff.append(",\"owner\":{");
			buff.append("\"url\":\"#\"");// 用户资料
			buff.append(",\"user_id\":\"");
			buff.append(anno.getUser().getId());
			buff.append("\",\"avatar\":\"#\"");// 用户头像
			buff.append(",\"name\":\"");
			buff.append(anno.getUser().getName());
			buff.append("\"}");
		}
		buff.append(",\"endContainerId\":\"");
		buff.append(anno.getEndContainerId());
		buff.append("\",\"startContainerId\":\"");
		buff.append(anno.getStartContainerId());
		buff.append("\",\"n_favorites\":0");
		buff.append(",\"type\":\"");
		buff.append(anno.getType());
		buff.append("\",\"id\":\"");
		buff.append(anno.getId());
		buff.append("\",\"tags\":[\"mine\"]}");
		return buff.toString();
	}

	private String getAnnoJSONForList(PEpubAnnotation anno) {
		StringBuffer buff = new StringBuffer();
		buff.append("{\"extra\":{\"percent\":0,\"text\":");
		buff.append(anno.getText() != null ? JSONUtil.string2Json(anno.getText()) : "\"\"");
		buff.append("},\"endOffset\": ");
		buff.append(anno.getEndOffset() != null ? anno.getEndOffset() : "0");
		buff.append(",\"visible_private\":\"");
		buff.append(anno.getVisiblePrivate() == null ? "" : anno.getVisiblePrivate());
		buff.append("\",\"middleContainers\":[");
		buff.append(anno.getMiddleContainers() == null ? "" : anno.getMiddleContainers());
		buff.append("],\"note\":");
		buff.append(anno.getNote() != null ? JSONUtil.string2Json(anno.getNote()) : "\"\"");
		buff.append(",\"n_comments\":0");
		buff.append(",\"create_time\":\"");
		buff.append(anno.getCreateOn() != null ? (DateUtil.getNowDate("yyyy-MM-dd hh:mm:ss", anno.getCreateOn()).replace(' ', 'T') + "+08:00") : "");
		buff.append("\",\"startOffset\":");
		buff.append(anno.getStartOffset() != null ? anno.getStartOffset() : "0");
		if (anno.getUser() != null) {
			buff.append(",\"owner\":{");
			buff.append("\"url\":\"#\"");// 用户资料
			buff.append(",\"user_id\":\"");
			buff.append(anno.getUser().getId());
			buff.append("\",\"avatar\":\"#\"");// 用户头像
			buff.append(",\"name\":\"");
			buff.append(anno.getUser().getName());
			buff.append("\"}");
		}
		buff.append(",\"endContainerId\":\"");
		buff.append(anno.getEndContainerId() != null ? anno.getEndContainerId() : "");
		buff.append("\",\"startContainerId\":\"");
		buff.append(anno.getStartContainerId() != null ? anno.getStartContainerId() : "");
		buff.append("\",\"n_favorites\":0");
		buff.append(",\"type\":\"");
		buff.append(anno.getType());
		buff.append("\",\"id\":\"");
		buff.append(anno.getId());
		buff.append("\",\"tags\":[\"mine\"]}");
		return buff.toString();

	}

	private void addLog(String pubid, CUser user, String institutionId, String ip, HttpServletRequest request) throws Exception {

		String Agent = request.getHeader("User-Agent");

		LAccess access = new LAccess();

		access.setAccess(1);// 访问状态1-访问成功 2-访问拒绝
		access.setType(2);// 操作类型1-访问摘要 2-访问内容 3-检索
		access.setCreateOn(new Date());
		access.setIp(ip);
		access.setPlatform("CNPe");
		access.setClientInfo(Agent);
		access.setYear(StringUtil.formatDate(access.getCreateOn(), "yyyy"));
		access.setMonth(StringUtil.formatDate(access.getCreateOn(), "MM"));
		if ("01".equals(access.getMonth()))
			access.setMonth1(1);
		if ("02".equals(access.getMonth()))
			access.setMonth2(1);
		if ("03".equals(access.getMonth()))
			access.setMonth3(1);
		if ("04".equals(access.getMonth()))
			access.setMonth4(1);
		if ("05".equals(access.getMonth()))
			access.setMonth5(1);
		if ("06".equals(access.getMonth()))
			access.setMonth6(1);
		if ("07".equals(access.getMonth()))
			access.setMonth7(1);
		if ("08".equals(access.getMonth()))
			access.setMonth8(1);
		if ("09".equals(access.getMonth()))
			access.setMonth9(1);
		if ("10".equals(access.getMonth()))
			access.setMonth10(1);
		if ("11".equals(access.getMonth()))
			access.setMonth11(1);
		if ("12".equals(access.getMonth()))
			access.setMonth12(1);
		PPublications publications = new PPublications();
		publications.setId(pubid);
		access.setPublications(publications);

		access.setUserId(user != null ? user.getId() : null);
		access.setInstitutionId(institutionId);
		this.logAOPService.addLog(access);
	}
}
