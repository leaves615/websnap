package cn.leaves.websnap.pager;

import java.util.Collection;

/**
 * 分页类
 * Created by leaves on 14-9-28.
 */
public class Pager<T> {
    private int index;
    //分页的大小
    private int pageSize;
    //起始页
    private int pageNo;
    //总记录数
    private int total;
    //分页的数据
    private Collection<T> datas;

    public Pager(){
    }
    
    public Pager(int index, int pageSize) {
        this.index = index;
        this.pageSize = pageSize;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public Collection<T> getDatas() {
		return datas;
	}

	public void setDatas(Collection<T> datas) {
		this.datas = datas;
	}

    public int getOffset() {
        return index*pageSize;
    }

}
