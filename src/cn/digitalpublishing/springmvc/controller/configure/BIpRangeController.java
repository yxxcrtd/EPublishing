package cn.digitalpublishing.springmvc.controller.configure;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.ccsit.restful.tool.Converter;
import cn.com.daxtech.framework.Internationalization.Lang;
import cn.com.daxtech.framework.model.ResultObject;
import cn.com.daxtech.framework.util.ObjectUtil;
import cn.digitalpublishing.ep.po.BIpRange;
import cn.digitalpublishing.springmvc.controller.BaseController;

@Controller
@RequestMapping("/pages/ipRange")
public class BIpRangeController extends BaseController {

	/**
	 * 数据接口
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public void insert(HttpServletRequest request, Model model){
		ResultObject<BIpRange> result=null;
		try{
			String objJson = request.getParameter("obj").toString();
			String operType = request.getParameter("operType").toString(); //1-insert 2-update
			Converter<BIpRange> converter=new Converter<BIpRange>();
			BIpRange obj=(BIpRange)converter.json2Object(objJson, BIpRange.class.getName());
			if("2".equals(operType)){
				BIpRange ip = this.configureService.getIpRange(obj.getId());
				if(ip!=null){
					this.configureService.updateIpRange(obj,obj.getId(), null);
					this.customService.handleLicenseIp(obj.getInstitution().getId());//更新的时候走原来的方法 by zhoudong 2015-11-17
				}else{
					this.configureService.insertIpRange(obj);
					this.customService.handleLicenseipinsert(obj);//增加一条ip信息，就关联一个Ip的关系的  by zhoudong 2015-11-16
				}
			}else if ("1".equals(operType)){
				//1.写入IP信息
				this.configureService.insertIpRange(obj);
				this.customService.handleLicenseipinsert(obj);//增加一条ip信息，就关联一个Ip的关系的  by zhoudong 2015-11-16
			}else{
				//删除
				BIpRange ip = this.configureService.getIpRange(obj.getId());
				obj.setInstitution(ip.getInstitution());
				this.configureService.deleteIpRange(obj.getId());
				this.customService.handleLicenseIp(obj.getInstitution().getId());// 删除的时候走原来的方法by zhoudong 2015-11-17
			}
			//2.写入License信息 逻辑：先删除后新增，先删除拥有这个License的用户所在机构的所有产品的LicenseIP，然后再增加，如果用户没有机构则不处理。
			//this.customService.handleLicenseIp(obj.getInstitution().getId());战时先屏蔽这个。by zhoudong 2015-11-19 新增的走新写的，删除和修改还走这个方法，在上面。
			ObjectUtil<BIpRange> util=new ObjectUtil<BIpRange>();
			obj=util.setNull(obj, new String[]{Set.class.getName()});
			result=new ResultObject<BIpRange>(1,obj,Lang.getLanguage("ipRange.info.maintain.success",request.getSession().getAttribute("lang").toString()));//"IP范围信息维护成功！");
		}catch(Exception e){
			result=new ResultObject<BIpRange>(2,Lang.getLanguage("ipRange.info.maintain.error",request.getSession().getAttribute("lang").toString()));//"IP范围信息维护失败！");
		}
		model.addAttribute("target",result);
	}
}
