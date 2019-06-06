package cn.digitalpublishing.springmvc.controller.advertisement;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import cn.digitalpublishing.ep.po.OAdvertisement;
import cn.digitalpublishing.springmvc.controller.BaseController;
import cn.digitalpublishing.springmvc.form.advertisement.OAdvertisementForm;
import cn.digitalpublishing.util.io.FileUtil;
import cn.digitalpublishing.util.web.DateUtil;

/**
 * 广告
 * 
 * @author LiuYe
 */
@Controller
@RequestMapping("/pages/advertisement")
public class AdvertisementController extends BaseController {
	
	/**
	 * 查询广告列表
	 * 
	 * @param request
	 * @param response
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/form/list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, OAdvertisementForm form) throws Exception {
		String forwardString = "advertisement/list";
		Map<String, Object> condition = new HashMap<String, Object>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<OAdvertisement> list = new ArrayList<OAdvertisement>();
		try {
			form.setUrl(request.getRequestURL().toString());
			form.setCount(this.oAdertisementService.getCount(condition));
			list = this.oAdertisementService.getPagingList(condition, "", form.getPageCount(), form.getCurpage());
			model.put("list", list);
			model.put("form", form);
		} catch (Exception e) {
			request.setAttribute("message", (e instanceof CcsException) ? Lang.getLanguage(((CcsException) e).getPrompt(), request.getSession().getAttribute("lang").toString()) : e.getMessage());
			forwardString = "error";
		}
		return new ModelAndView(forwardString, model);
	}

	/**
	 * 查询广告列表
	 * 
	 * @param request
	 * @param response
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/form/listForIndex")
	public ModelAndView listForIndex(HttpServletRequest request, HttpServletResponse response, OAdvertisementForm form) throws Exception {
		String forwardString = "advertisement/indextop";
		Map<String, Object> condition = new HashMap<String, Object>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<OAdvertisement> list = new ArrayList<OAdvertisement>();
		try {
			form.setUrl(request.getRequestURL().toString());
			condition.put("position", form.getPosition());
			condition.put("status", form.getStatus());
			DateFormat dateFmt = new SimpleDateFormat("yyyy-MM-dd");
			condition.put("inDate", dateFmt.format(new Date()));
			list = this.oAdertisementService.getPagingList(condition, " order by a.createTime desc ", form.getPageCount(), form.getCurpage());
			model.put("list", list);
			model.put("form", form);
			switch (form.getPosition()) {
			case 2:
				forwardString = "advertisement/indexbottom";
				break;
			case 3:
				forwardString = "advertisement/cnebooktop";
				break;
			case 4:
				forwardString = "advertisement/enebooktop";
				break;
			case 5:
				forwardString = "advertisement/journaltop";
				break;
			default:
				forwardString = "advertisement/indextop";
				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
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
	 */
	@RequestMapping(value = "/form/edit")
	public ModelAndView edit(HttpServletRequest request, HttpServletResponse response, OAdvertisementForm form) throws Exception {
		String forwardString = "advertisement/edit";
		Map<String, Object> model = new HashMap<String, Object>();
		OAdvertisement obj = new OAdvertisement();
		try {
			if (form.getId() != null && !form.getId().equals("")) {
				obj = this.oAdertisementService.getObjById(form.getId());
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
	 */
	@RequestMapping(value = "/form/save")
	public ModelAndView picDelete(HttpServletRequest request, HttpServletResponse response, OAdvertisementForm form) throws Exception {
		OAdvertisement obj = form.getObj();
		try {
			if ((form.getFile() != null) && (form.getFile().getSize() != 0)) {
				String root = request.getSession().getServletContext().getRealPath("");
				String path = "/images/ad";// + DateUtil.getNowDate("yyyyMMdd");
				String folderName = root + path;
				FileUtil.newFolder(folderName);
				String filename = form.getFile().getOriginalFilename();
				String fileFormat = filename.substring(filename.lastIndexOf(".") + 1);
				String name = String.valueOf(System.currentTimeMillis());
				FileUtil.writeFile(folderName + "/" + name + "." + fileFormat, form.getFile().getFileItem().get());
				obj.setFile(path + "/" + name + "." + fileFormat);
			}
			obj.setStartTime(DateUtil.getUtilDate(form.getStartTime(), "yyyy-MM-dd"));
			obj.setEndTime(DateUtil.getUtilDate(form.getEndTime(), "yyyy-MM-dd"));
			obj.setCreateTime(new Date());
			if (form.getId() != null && !form.getId().equals("")) {
				this.oAdertisementService.updateObj(obj, form.getId(), null);
			} else {
				this.oAdertisementService.insertObj(form.getObj());
			}
			form.setMsg(form.getId() != null && !form.getId().equals("") ? "修改广告信息成功" : "新增广告信息成功");
		} catch (Exception e) {
			form.setMsg((e instanceof CcsException) ? ((CcsException) e).getMessage() : e.getMessage());
		}
		return this.list(request, response, form);
	}

	/**
	 * 删除广告
	 * 
	 * @param form
	 * @param response
	 * @param request
	 */
	@RequestMapping(value = "/form/delete")
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response, OAdvertisementForm form) throws Exception {
		try {
			this.oAdertisementService.deleteObj(form.getId());
			form.setMsg("删除广告信息成功");
		} catch (Exception e) {
			form.setMsg((e instanceof CcsException) ? ((CcsException) e).getMessage() : e.getMessage());
		}
		return this.list(request, response, form);
	}
	
}
