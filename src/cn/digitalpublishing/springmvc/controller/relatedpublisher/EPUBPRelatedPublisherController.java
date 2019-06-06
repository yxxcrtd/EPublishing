package cn.digitalpublishing.springmvc.controller.relatedpublisher;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.com.daxtech.framework.model.Param;
import cn.digitalpublishing.ep.po.PRelatedPublisher;
import cn.digitalpublishing.springmvc.controller.BaseController;
import cn.digitalpublishing.springmvc.form.relatedpublisher.RelatedPublisherForm;
import cn.digitalpublishing.util.io.FileUtil;

@Controller
@RequestMapping(value="/pages/RelatedPublisher")
public class EPUBPRelatedPublisherController extends BaseController {
	@RequestMapping(value="/form/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response, RelatedPublisherForm form) {
		String forwardString = "relatedpublisher/list";
		Map<String, Object> condition = new HashMap<String, Object>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<PRelatedPublisher> list = new ArrayList<PRelatedPublisher>();
		try {
			switch(form.getPosition()){
			case 1:
				forwardString = "relatedpublisher/pubforcnbooklist";
				break;
			case 2:
				forwardString = "relatedpublisher/pubforenbooklist";
				break;
			case 3:
				forwardString = "relatedpublisher/pubforjournallist";
				break;
			
			}
			condition.put("position", form.getPosition());
			list = this.pRelatedPublisherService.getPagingList(condition, " order by a.orderMark ",form.getPageCount(), form.getCurpage());
			model.put("list", list);
			model.put("form", form);
		} catch (Exception e) {
			form.setMsg(e.getMessage());
		}
		return new ModelAndView(forwardString, model);
	}

	@RequestMapping("/form/edit")
	public ModelAndView edit(HttpServletRequest request,HttpServletResponse response, RelatedPublisherForm form) {
		String forwardString = "relatedpublisher/edit";
		Map<String, Object> model = new HashMap<String, Object>();
		PRelatedPublisher obj=new PRelatedPublisher();
		try {
			if(form.getId()!=null&&!form.getId().equals("")){
				obj=this.pRelatedPublisherService.getById(form.getId());
			}
			model.put("obj", obj);
			model.put("form", form);
		} catch (Exception e) {
			form.setMsg(e.getMessage());
		}
		return new ModelAndView(forwardString, model);
	}
	@RequestMapping("/form/save")
	public ModelAndView save(HttpServletRequest request,HttpServletResponse response, RelatedPublisherForm form) {
		HashMap<String,Object> model = new HashMap<String,Object>();
		String forwardString="msg";
		PRelatedPublisher obj=form.getObj();
		try {
			if ((form.getPicPath() != null) && (form.getPicPath().getSize() != 0)) {
				String root = Param.getParam("upload").get("dir")
						.replace("-", ":");
				String path = "/relatedpublisher";// + DateUtil.getNowDate("yyyyMMdd");
				String folderName = root + path;
				FileUtil.newFolder(folderName);
				String filename = form.getPicPath().getOriginalFilename();
				String fileFormat = filename.substring(filename.lastIndexOf(".") + 1);
				String name = String.valueOf(System.currentTimeMillis());
				FileUtil.writeFile(folderName + "/" + name + "." + fileFormat, form.getPicPath().getFileItem().get());
				obj.setPicPath(path + "/" + name + "." + fileFormat);
			}
			if(form.getId()!=null&&!form.getId().equals("")){
				this.pRelatedPublisherService.update(obj, form.getId(), null);
				this.pRelatedPublisherService.syncToEPUB(form.getId());
			}else{
				this.pRelatedPublisherService.insert(obj);
				this.pRelatedPublisherService.syncToEPUB(obj.getId());
			}
			form.setMsg("操作成功！");
			model.put("form", form);
		} catch (Exception e) {
			form.setMsg(e.getMessage());
		}
		return new ModelAndView(forwardString,model);
	}
	@RequestMapping("/form/delete")
	public ModelAndView delete(HttpServletRequest request,HttpServletResponse response, RelatedPublisherForm form) {
		try {
			this.pRelatedPublisherService.delete(form.getId());
			this.pRelatedPublisherService.syncToEPUB(form.getId());
			form.setMsg("操作成功！");
		} catch (Exception e) {
			form.setMsg(e.getMessage());
		}
		return this.list(request, response, form);
	}

}
