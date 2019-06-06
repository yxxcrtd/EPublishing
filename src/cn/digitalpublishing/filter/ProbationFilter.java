package cn.digitalpublishing.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.digitalpublishing.util.bean.ProbationInfo;

public class ProbationFilter extends HttpServlet implements Filter {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static Map<String, ProbationInfo> probationMap = new HashMap<String, ProbationInfo>();
	//private ServiceFactory serviceFactory = (ServiceFactory) new ServiceFactoryImpl();
	private FilterConfig filterConfig;

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		this.filterConfig = arg0;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		String noLicense_dispathcher = "" ; 
		String recommend_dispathcher = "" ; 
		// String path = req.getServletPath();
		try {
			if (null != req.getServletPath()
					&& req.getServletPath().contains("/form/page")) {
				boolean probationFlag = null != req.getParameter("probation")
						&& "probation".equals(req.getParameter("probation")) ? true: false;
				// 试读链接
				if (probationFlag) {
					// 从Map缓存中获取信息
					String pageNum = req.getParameter("pageNum");
					String pubId = req.getParameter("pubId");
					long currentPage = 0;
					if (null != pageNum && !"".equals(pageNum) && null != pubId && !"".equals(pageNum)) {
						ProbationInfo pi = ProbationFilter.probationMap.get(pubId);
						// 判断是 PNG<false>|SWF<true> 阅读器
						boolean viewFlag = req.getServletPath().contains("/view/png") ? false : true ; 
						// SWF阅读器
						if(viewFlag){
							noLicense_dispathcher = "/pages/view/form/errorProbation" ; 
							recommend_dispathcher = "/pages/view/form/probationEndTip";
						// PNG阅读器
						}else{
							noLicense_dispathcher = "/pages/view/png/form/errorProbation" ; 
							recommend_dispathcher = "/pages/view/png/form/probationEndTip";
						}						
						if (null != pi && pi.getLimitPageNum() > 0l) {
							// 判断当前页面和是否超出限制页数
							currentPage = Long.parseLong(pageNum);
							if (currentPage > pi.getLimitPageNum()) {
								//返回无lincense界面
								req.getRequestDispatcher(noLicense_dispathcher).forward(req, resp);
								return;
							}else if(currentPage == pi.getLimitPageNum()){
								//加载最后的"推荐"页面
								req.getRequestDispatcher(recommend_dispathcher).forward(req, resp);
								return;
							}
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		chain.doFilter(request, response);
	}

}