package cn.leaves.websnap.batis.entity;

public class Pagecollectcontent {
    public Pagecollectcontent(Long pageid, Long contentruleid, String content) {
        this.pageid = pageid;
        this.contentruleid = contentruleid;
        this.content = content;
    }

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column pageCollectContent.id
     *
     * @mbggenerated
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column pageCollectContent.pageId
     *
     * @mbggenerated
     */
    private Long pageid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column pageCollectContent.contentRuleId
     *
     * @mbggenerated
     */
    private Long contentruleid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column pageCollectContent.content
     *
     * @mbggenerated
     */
    private String content;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column pageCollectContent.id
     *
     * @return the value of pageCollectContent.id
     *
     * @mbggenerated
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column pageCollectContent.id
     *
     * @param id the value for pageCollectContent.id
     *
     * @mbggenerated
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column pageCollectContent.pageId
     *
     * @return the value of pageCollectContent.pageId
     *
     * @mbggenerated
     */
    public Long getPageid() {
        return pageid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column pageCollectContent.pageId
     *
     * @param pageid the value for pageCollectContent.pageId
     *
     * @mbggenerated
     */
    public void setPageid(Long pageid) {
        this.pageid = pageid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column pageCollectContent.contentRuleId
     *
     * @return the value of pageCollectContent.contentRuleId
     *
     * @mbggenerated
     */
    public Long getContentruleid() {
        return contentruleid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column pageCollectContent.contentRuleId
     *
     * @param contentruleid the value for pageCollectContent.contentRuleId
     *
     * @mbggenerated
     */
    public void setContentruleid(Long contentruleid) {
        this.contentruleid = contentruleid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column pageCollectContent.content
     *
     * @return the value of pageCollectContent.content
     *
     * @mbggenerated
     */
    public String getContent() {
        return content;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column pageCollectContent.content
     *
     * @param content the value for pageCollectContent.content
     *
     * @mbggenerated
     */
    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
}