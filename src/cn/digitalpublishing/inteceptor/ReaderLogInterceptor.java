package cn.digitalpublishing.inteceptor;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;

import cn.com.daxtech.framework.util.StringUtil;
import cn.digitalpublishing.ep.po.BInstitution;
import cn.digitalpublishing.ep.po.CUser;
import cn.digitalpublishing.ep.po.LAccess;
import cn.digitalpublishing.ep.po.LLicense;
import cn.digitalpublishing.ep.po.PPublications;
import cn.digitalpublishing.util.web.IpUtil;

public class ReaderLogInterceptor extends ActionInterceptor {
	
	public Logger logger = Logger.getLogger(ReaderLogInterceptor.class);
	@Override  
	public void afterCompletion(HttpServletRequest request,HttpServletResponse response, Object o, Exception e)throws Exception {  
		try{
			// 请求的URL全路径
			
			String url = request.getRequestURL().toString();
			String pubId = request.getParameter("pubId");
			String pageNum = request.getParameter("pageNum");
			String probation = request.getParameter("probation");//1：试读 2：试用 3：购买 9：未知
			//目前 链接里只有试读类型
			int accessFullType = 9;
			if(probation!=null&&"probation".equals(probation)){
				accessFullType = 1;
			}
			System.out.println("ReaderLogInterceptor拦截器.........");
			logger.info("*********************************--pubId="+pubId+"---pageNum="+pageNum+"-----url="+url);
			//System.out.println("*********************************--pubId="+pubId+"---pageNum="+pageNum+"-----url="+url);
			CUser user = null;
			if (request.getSession().getAttribute("mainUser")!=null){
				user = (CUser)request.getSession().getAttribute("mainUser");
			}
			BInstitution institution = null;
			if(request.getSession().getAttribute("institution")!=null){
				institution=(BInstitution)request.getSession().getAttribute("institution");
			}else{
				if(user!=null){
					institution=user.getInstitution()==null?null:user.getInstitution();
				}
			}
			
			LAccess access = new LAccess();
			access.setAccess(1);
			access.setType(2);
			access.setCreateOn(new Date());
			access.setIp(IpUtil.getIp(request));
			access.setInstitutionId(institution==null?null:institution.getId());
			access.setPlatform("CNPe");
			access.setYear(StringUtil.formatDate(access.getCreateOn(),"yyyy"));
			access.setMonth(StringUtil.formatDate(access.getCreateOn(),"MM"));
			//新增
			access.setAccessDate(StringUtil.formatDate(access.getCreateOn(),"yyyyMMdd"));
			if(probation==null){
				LLicense license = null;
				if(user!=null&&institution!=null){
					String userId = null;	
					userId = user.getId();
					//pubId = "ff8080813d43f66f013d4447ee7e0000";
					//userId = "402881ba3c6996ee013c6a567b6f0048";
					logger.info("------"+userId);
					List<LLicense> list = this.serviceFactory.getBookSuppliersService().getLicense(userId, pubId);
				
					if(list!=null){
						license = list.get(0);
						int isTrial = license.getIsTrial();//是否是试用授权1-是，2-不是，null-不是
						logger.info("-------------------"+isTrial);
						//isTrial = 2;
						if(isTrial==1){
							accessFullType = 2;//全文类型	1：试读 2：试用 3：购买  9:未知
						}else if(isTrial==2){
							//到订单表查询 //类型 1-电子书 2-期刊 3-章节 4-文章 5-数据库 6-期刊卷 7 期刊期   99产品包(用来在订单明细中区分)
							//int type = license.getPublications().getType();
							Map<String,Object> condition = new HashMap<String,Object>();
							condition.put("userId", userId);
							condition.put("productCode", license.getCode());
							logger.info("-------------------"+condition);
							//condition.put("", license.getPublications().getEissn());
							List<cn.digitalpublishing.ep.po.OOrderDetail> odlist = this.serviceFactory.getOOrderService().getBuyBookList(condition, "");
							if(odlist!=null&&odlist.size()>0){
								accessFullType = 3;//全文类型	1：试读 2：试用 3：购买  9:未知
							}
						}
					}
					
				}
			}
			logger.info("-------------------"+accessFullType);
			access.setAccessFullType(accessFullType);//全文类型	1：试读 2：试用 3：购买 9 未知
			
			access.setUserId(user==null?null:user.getId());
			PPublications publications = new PPublications();
			publications.setId(pubId);
			access.setPublications(publications);
			Integer yue = Integer.valueOf(StringUtil.formatDate(new Date(),"MM"));
			switch (yue) {
				case 1:{
					access.setMonth1(access.getMonth1()==null?1:(access.getMonth1()+1));
					break;
				}
				case 2:{
					access.setMonth2(access.getMonth2()==null?1:(access.getMonth2()+1));
					break;
				}
				case 3:{
					access.setMonth3(access.getMonth3()==null?1:(access.getMonth3()+1));
					break;
				}
				case 4:{
					access.setMonth4(access.getMonth4()==null?1:(access.getMonth4()+1));
					break;
				}
				case 5:{
					access.setMonth5(access.getMonth5()==null?1:(access.getMonth5()+1));
					break;
				}
				case 6:{
					access.setMonth6(access.getMonth6()==null?1:(access.getMonth6()+1));
					break;
				}
				case 7:{
					access.setMonth7(access.getMonth7()==null?1:(access.getMonth7()+1));
					break;
				}
				case 8:{
					access.setMonth8(access.getMonth8()==null?1:(access.getMonth8()+1));
					break;
				}
				case 9:{
					access.setMonth9(access.getMonth9()==null?1:(access.getMonth9()+1));
					break;
				}
				case 10:{
					access.setMonth10(access.getMonth10()==null?1:(access.getMonth10()+1));
					break;
				}
				case 11:{
					access.setMonth11(access.getMonth11()==null?1:(access.getMonth11()+1));
					break;
				}
				case 12:{
					access.setMonth12(access.getMonth12()==null?1:(access.getMonth12()+1));
					break;
				}
				default:{
					access.setMonth1(access.getMonth1()==null?1:(access.getMonth1()+1));
					break;
				}
			}
			this.serviceFactory.getLogAOPService().addLog(access);
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
//		System.out.println("Publication拦截器结束。。。。");
	}  

	@Override  
	public void postHandle(HttpServletRequest request, HttpServletResponse response,Object o, ModelAndView mv) throws Exception {  
//		System.out.println("Publication拦截器工作。。。。");   
//		String s = "------- Inteceptor --------: Publication !";  
//		System.out.println(s);  
//		mv.addObject("intep",s);
//		HandlerMethod handlerMethod = (HandlerMethod) o;
//		for (MethodParameter methodParameter : handlerMethod.getMethodParameters()) {
//			methodParameter.getParameterName();//怎么获取参数值？获取username 和password7.        }
//		}
	}  
	
	@Override  
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object o) throws Exception {  
//		System.out.println("Publication拦截器开启。。。。");    
		return true;  
	} 

}
