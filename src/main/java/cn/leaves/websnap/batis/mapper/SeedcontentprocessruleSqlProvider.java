package cn.leaves.websnap.batis.mapper;

import static org.apache.ibatis.jdbc.SqlBuilder.BEGIN;
import static org.apache.ibatis.jdbc.SqlBuilder.INSERT_INTO;
import static org.apache.ibatis.jdbc.SqlBuilder.SET;
import static org.apache.ibatis.jdbc.SqlBuilder.SQL;
import static org.apache.ibatis.jdbc.SqlBuilder.UPDATE;
import static org.apache.ibatis.jdbc.SqlBuilder.VALUES;
import static org.apache.ibatis.jdbc.SqlBuilder.WHERE;

import cn.leaves.websnap.batis.entity.Seedcontentprocessrule;

public class SeedcontentprocessruleSqlProvider {

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seedContentProcessRule
     *
     * @mbggenerated
     */
    public String insertSelective(Seedcontentprocessrule record) {
        BEGIN();
        INSERT_INTO("seedContentProcessRule");
        
        if (record.getId() != null) {
            VALUES("id", "#{id,jdbcType=BIGINT}");
        }
        
        if (record.getPageid() != null) {
            VALUES("pageId", "#{pageid,jdbcType=BIGINT}");
        }
        
        if (record.getCollectvar() != null) {
            VALUES("collectVar", "#{collectvar,jdbcType=VARCHAR}");
        }
        
        if (record.getCollecttype() != null) {
            VALUES("collectType", "#{collecttype,jdbcType=VARCHAR}");
        }
        
        if (record.getCollectlabel() != null) {
            VALUES("collectLabel", "#{collectlabel,jdbcType=VARCHAR}");
        }
        
        if (record.getCollectpattern() != null) {
            VALUES("collectPattern", "#{collectpattern,jdbcType=VARCHAR}");
        }
        
        if (record.getStorage() != null) {
            VALUES("storage", "#{storage,jdbcType=BIT}");
        }
        
        if (record.getConditional() != null) {
            VALUES("conditional", "#{conditional,jdbcType=BIT}");
        }

        if (record.getConditionpattern() != null) {
            VALUES("conditionPattern", "#{conditionpattern,jdbcType=VARCHAR}");
        }
        
        return SQL();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seedContentProcessRule
     *
     * @mbggenerated
     */
    public String updateByPrimaryKeySelective(Seedcontentprocessrule record) {
        BEGIN();
        UPDATE("seedContentProcessRule");
        
        if (record.getPageid() != null) {
            SET("pageId = #{pageid,jdbcType=BIGINT}");
        }
        
        if (record.getCollectvar() != null) {
            SET("collectVar = #{collectvar,jdbcType=VARCHAR}");
        }
        
        if (record.getCollecttype() != null) {
            SET("collectType = #{collecttype,jdbcType=VARCHAR}");
        }
        
        if (record.getCollectlabel() != null) {
            SET("collectLabel = #{collectlabel,jdbcType=VARCHAR}");
        }
        
        if (record.getCollectpattern() != null) {
            SET("collectPattern = #{collectpattern,jdbcType=VARCHAR}");
        }
        
        if (record.getStorage() != null) {
            SET("storage = #{storage,jdbcType=BIT}");
        }
        
        if (record.getConditional() != null) {
            SET("conditional = #{conditional,jdbcType=BIT}");
        }
        
        if (record.getConditionpattern() != null) {
            SET("conditionPattern = #{conditionpattern,jdbcType=VARCHAR}");
        }
        
        WHERE("id = #{id,jdbcType=BIGINT}");
        
        return SQL();
    }
}