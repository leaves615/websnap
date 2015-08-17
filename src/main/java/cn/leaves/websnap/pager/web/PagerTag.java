package cn.leaves.websnap.pager.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Enumeration;

/**
 * 分页标签处理类
 */
public class PagerTag extends TagSupport  {
   
	private static final long serialVersionUID = 5729832874890369508L;  
    private String url;         //请求URI  
    private int pageSize = 10;  //每页要显示的记录数  
    private long pageNo = 1;     //当前页号
    private long recordCount;    //总记录数

    @SuppressWarnings("unchecked")
	public int doStartTag() throws JspException {
    	long pageCount = (recordCount + pageSize - 1) / pageSize;  //计算总页数
    	//拼写要输出到页面的HTML文本  
        StringBuilder sb = new StringBuilder();
        sb.append("<div class=\"row\"><div class=\"col-xs-12\">\r\n");
        if(recordCount == 0){  
            sb.append("<strong>没有可显示的项目</strong>\r\n");  
        }else{
        	//页号越界处理  
            if(pageNo > pageCount){      pageNo = pageCount; }  
            if(pageNo < 1){      pageNo = 1; } 
            sb.append("<form method=\"get\" enctype=\"application/x-www-form-urlencoded\"  action=\"").append(this.url)
            .append("\" name=\"qPagerForm\">\r\n");
            
            //获取请求中的所有参数  
            HttpServletRequest request = (HttpServletRequest) pageContext
                    .getRequest();  
            Enumeration<String> enumeration = request.getParameterNames();  
            String name = null;  //参数名  
            String value = null; //参数值
            //把请求中的所有参数当作隐藏表单域
            while (enumeration.hasMoreElements()) {  
                name =  enumeration.nextElement();  
                value = request.getParameter(name);
                // 去除页号  
                if (name.equals("pageNo")) {  
                    if (null != value && !"".equals(value)) {
                        pageNo = Integer.parseInt(value);  
                    }
                    continue;  
                }
                sb.append("<input type=\"hidden\" name=\"")
                        .append(name)
                        .append("\" value=\"")
                        .append(value)
                        .append("\"/>\r\n");
            }
            
            //把当前页号设置成请求参数  
            sb.append("<input type=\"hidden\" name=\"").append("pageNo")  
                .append("\" value=\"").append(pageNo).append("\"/>\r\n");
            sb.append("<ul class=\"pagination pull-right no-margin\">");
            // 输出统计数据
            sb.append("<li class=\"disabled")
                    .append("\">\n" +
                            "<a href=\"#\">"+recordCount+"条/"+pageCount+"页</a>\n" +
                            "</li>");
            //上一页处理  
            sb.append("<li class=\"prev ")
                    .append(pageNo == 1?"disabled":"")
                    .append("\">\n" +
                            "<a href=\"javascript:turnOverPage(")
                    .append(pageNo - 1)
                    .append(")\">\n" +
                            "<i class=\"ace-icon fa fa-angle-double-left\"></i>\n" +
                            "</a>\n" +
                            "</li>");
            
            //如果前面页数过多,显示"..."  
            long start = 1;

            //显示当前页附近的页  
            long end = 9;
            if (pageNo > 5) {
                start = pageNo - 4;
                end = pageNo + 4;
            }

            end = pageCount>9?end : pageCount;

            if (end >9 && end > pageCount) {
                end = pageCount;
                start = end -9;
            }

            for(long i = start; i <= end; i++){
            	if(i>pageCount)break;
                if(pageNo == i){   //当前页号不需要超链接  
                    sb.append("<li class=\"active\">\n" +
                              "<a href=\"#\" class=\"diabled\">"+(i)+"</a>\n" +
                              "</li>");
                }else {
                    sb.append("<li>\n" +
                              "<a href=\"javascript:turnOverPage(" + (i) + ")\">" + (i) + "</a>\n" +
                              "</li>");
                }
            }

            
          //下一页处理  
            sb.append("<li class=\"next ")
                    .append(pageNo == pageCount?"disabled":"")
                    .append("\">\n" +
                      "<a href=\"javascript:turnOverPage(")
                    .append(pageNo + 1)
                    .append(")\">\n" +
                            "<i class=\"ace-icon fa fa-angle-double-right\"></i>\n" +
                            "</a>\n" +
                            "</li>");
            sb.append("</ul>");
            sb.append("</form>\r\n");  
      
            // 生成提交表单的JS  
            sb.append("<script language=\"javascript\">\r\n");  
            sb.append("  function turnOverPage(no){\r\n");  
            sb.append("    if(no>").append(pageCount).append("){");  
            sb.append("      no=").append(pageCount).append(";}\r\n");  
            sb.append("    if(no<1){no=1;}\r\n");  
            sb.append("    document.qPagerForm.pageNo.value=no;\r\n");  
            sb.append("    document.qPagerForm.submit();\r\n");  
            sb.append("  }\r\n");  
            sb.append("</script>\r\n");
        }
        sb.append("</div></div>\r\n");
        
        //把生成的HTML输出到响应中  
        try {  
            pageContext.getOut().println(sb.toString());  
        } catch (IOException e) {  
            throw new JspException(e);  
        }  
        return SKIP_BODY;  //本标签主体为空,所以直接跳过主体
    }
    
    public void setUrl(String url) {  
        this.url = url;  
    }  
    public void setPageSize(int pageSize) {  
        this.pageSize = pageSize;  
    }  
    public void setPageNo(int pageNo) {  
        this.pageNo = pageNo;  
    }  
    public void setRecordCount(int recordCount) {  
        this.recordCount = recordCount;  
    } 
}
