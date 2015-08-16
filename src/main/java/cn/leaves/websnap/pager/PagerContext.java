package cn.leaves.websnap.pager;
/**
 * 用来传递列表对象的ThreadLocal数据
 * @author chen_wzhi
 *
 */
public class PagerContext {
	/**
	 * 分页大小
	 */
	private static ThreadLocal<Integer> pageSize = new ThreadLocal<Integer>();
	/**
	 * 分页的起始页
	 */
	private static ThreadLocal<Integer> pageNo = new ThreadLocal<Integer>();
	/**
	 * 列表的排序字段
	 */
	private static ThreadLocal<String> sort = new ThreadLocal<String>();
	/**
	 * 列表的排序方式
	 */
	private static ThreadLocal<String> order = new ThreadLocal<String>();
	
	private static ThreadLocal<String> realPath = new ThreadLocal<String>();
	
	
	
	public static String getRealPath() {
		return realPath.get();
	}
	public static void setRealPath(String _realPath) {
		PagerContext.realPath.set(_realPath);
	}
	public static Integer getPageSize() {
		int size = pageSize.get();
        return size == 0?20:size;
	}
	public static void setPageSize(Integer _pageSize) {
		pageSize.set(_pageSize);
	}
	public static Integer getPageNo() {
        int p = pageNo.get();
		return p ==0 ?1:p;
	}
	public static void setPageNo(Integer _pageNo) {
		pageNo.set(_pageNo);
	}
	public static String getSort() {
		return sort.get();
	}
	public static void setSort(String _sort) {
		PagerContext.sort.set(_sort);
	}
	public static String getOrder() {
		return order.get();
	}
	public static void setOrder(String _order) {
		PagerContext.order.set(_order);
	}
	
	public static void removePageSize() {
		pageSize.remove();
	}
	
	public static void removePageNo() {
		pageNo.remove();
	}
	
	public static void removeSort() {
		sort.remove();
	}
	
	public static void removeOrder() {
		order.remove();
	}
	
	public static void removeRealPath() {
		realPath.remove();
	}
	
}
