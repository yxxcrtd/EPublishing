package cn.digitalpublishing.springmvc.controller.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.digitalpublishing.ep.po.BService;
import cn.digitalpublishing.ep.po.CUser;
import cn.digitalpublishing.springmvc.controller.BaseController;
import cn.digitalpublishing.springmvc.form.service.ServiceForm;

@Controller
@RequestMapping(value="/pages/service")
public class EPUBServiceController extends BaseController {
	@RequestMapping(value="/form/listForIndex")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response, ServiceForm form) {
		String forwardString = "service/forindex";
		Map<String, Object> condition = new HashMap<String, Object>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<BService> preList = new ArrayList<BService>();
		List<BService> list = new ArrayList<BService>();
		try {
			form.setUrl(request.getRequestURL().toString());
			condition.put("type", 1);
			if(request.getSession().getAttribute("lang").toString().equalsIgnoreCase("en_us")){
				condition.put("type", 2);
			}
			preList = this.bServiceService.getPagingList(condition," ",form.getPageCount(),form.getCurpage());
			for (int i = 0; i < preList.size(); i++) {
				BService obj = preList.get(i);
				StringBuffer sb=new StringBuffer(obj.getContent());
				obj.setContent(changeContent(sb));
				list.add(obj);
			}
			model.put("list", list);
			model.put("form", form);
		} catch (Exception e) {
			form.setMsg(e.getMessage());
		}
		return new ModelAndView(forwardString, model);
	}
	
	@RequestMapping(value="/form/serviceList")
	public ModelAndView serviceList(HttpServletRequest request,HttpServletResponse response, ServiceForm form) {
		String forwardString = "service/servicelist";
		Map<String, Object> condition = new HashMap<String, Object>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<BService> list = new ArrayList<BService>();
		BService obj=null;
		try {
			condition.put("type", 1);
			if(request.getSession().getAttribute("lang").toString().equalsIgnoreCase("en_us")){
				condition.put("type", 2);
			}
			list = this.bServiceService.getPagingList(condition, "",
					3, form.getCurpage());
			for (int i = 0; i < list.size(); i++) {
				if(list.get(i).getId()==form.getServiceId()){
					obj=list.get(i);
					list.set(i, list.get(0));
					list.set(0, obj);
				}
			}
			form.setServiceId(form.getServiceId());
			model.put("list", list);
			model.put("form", form);
		} catch (Exception e) {
			form.setMsg(e.getMessage());
		}
		return new ModelAndView(forwardString, model);
	}
	@RequestMapping(value="/form/forServiceList")
	public ModelAndView forServiceList(HttpServletRequest request,HttpServletResponse response, ServiceForm form) {
		String forwardString = "service/forservicelist";
		Map<String, Object> model = new HashMap<String, Object>();
		BService obj=new BService();
		try {
			String id=form.getServiceId();
			obj=this.bServiceService.getObjById(id);
			model.put("obj", obj);
			model.put("form", form);
		} catch (Exception e) {
			form.setMsg(e.getMessage());
		}
		return new ModelAndView(forwardString, model);
	}

	@RequestMapping("/form/edit")
	public ModelAndView edit(HttpServletRequest request,HttpServletResponse response, ServiceForm form) {
		String forwardString = "service/edit";
		Map<String, Object> model = new HashMap<String, Object>();
		BService obj=new BService();
		try {
			if(form.getId()!=null&&!form.getId().equals("")){
				obj=this.bServiceService.getObjById(form.getId());
			}
			model.put("obj", obj);
			model.put("form", form);
		} catch (Exception e) {
			form.setMsg(e.getMessage());
		}
		return new ModelAndView(forwardString, model);
	}
	@RequestMapping("/form/save")
	public ModelAndView save(HttpServletRequest request,HttpServletResponse response, ServiceForm form) {
		HashMap<String,Object> model = new HashMap<String,Object>();
		String forwardString="msg";
		BService obj=form.getObj();
		try {
			if(form.getId()!=null&&!form.getId().equals("")){
				this.bServiceService.updateObj(obj, form.getId(), null);
			}else{
				this.bServiceService.insertObj(obj);
			}
			
			form.setMsg("操作成功！");
			model.put("form", form);
		} catch (Exception e) {
			form.setMsg(e.getMessage());
		}
		return new ModelAndView(forwardString,model);
	}
	@RequestMapping("/form/delete")
	public ModelAndView delete(HttpServletRequest request,HttpServletResponse response, ServiceForm form) {
		try {
			this.bServiceService.deleteObj(form.getId());
			form.setMsg("操作成功！");
		} catch (Exception e) {
			form.setMsg(e.getMessage());
		}
		return this.list(request, response, form);
	}
	/**
	 * 转换ue.getContent() 去标签
	 * @param str
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public String changeContent(StringBuffer str)throws Exception{
		try {
			while(str.indexOf("<")!=-1&&str.indexOf(">")!=-1){
			int k=str.lastIndexOf("<");
			int k1=str.lastIndexOf(">");
			String b=str.substring(k,k1+1);
			str.replace(k, k1+1, "");
			}
			return str.toString();
		} catch (Exception e) {
			throw e;
		}
	}
}
