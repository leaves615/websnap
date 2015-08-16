package cn.leaves.websnap.serlvet.filter;


import cn.leaves.websnap.pager.PagerContext;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class PagerContextFilter implements Filter{
	private Integer pageSize;

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		req.setAttribute("ctx", ((HttpServletRequest)req).getContextPath());
		Integer pageNo = 0;
		try {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		} catch (NumberFormatException e) {}
		try {
			PagerContext.setOrder(req.getParameter("order"));
			PagerContext.setSort(req.getParameter("sort"));
			PagerContext.setPageNo(pageNo);
			PagerContext.setPageSize(pageSize);
			PagerContext.setRealPath(((HttpServletRequest)req).getSession().getServletContext().getRealPath("/"));
			chain.doFilter(req,resp);
		} finally {
			PagerContext.removeOrder();
			PagerContext.removeSort();
			PagerContext.removePageNo();
			PagerContext.removePageSize();
			PagerContext.removeRealPath();
		}
	}

	@Override
	public void init(FilterConfig cfg) throws ServletException {
		try {
			pageSize = Integer.parseInt(cfg.getInitParameter("pageSize"));
		} catch (NumberFormatException e) {
			pageSize = 15;
		}
	}

}
