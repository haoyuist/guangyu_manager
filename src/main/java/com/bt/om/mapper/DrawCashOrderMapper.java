package com.bt.om.mapper;

import com.bt.om.entity.DrawCashOrder;

public interface DrawCashOrderMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table draw_cash_order
     *
     * @mbg.generated Mon Apr 23 15:09:31 CST 2018
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table draw_cash_order
     *
     * @mbg.generated Mon Apr 23 15:09:31 CST 2018
     */
    int insert(DrawCashOrder record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table draw_cash_order
     *
     * @mbg.generated Mon Apr 23 15:09:31 CST 2018
     */
    int insertSelective(DrawCashOrder record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table draw_cash_order
     *
     * @mbg.generated Mon Apr 23 15:09:31 CST 2018
     */
    DrawCashOrder selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table draw_cash_order
     *
     * @mbg.generated Mon Apr 23 15:09:31 CST 2018
     */
    int updateByPrimaryKeySelective(DrawCashOrder record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table draw_cash_order
     *
     * @mbg.generated Mon Apr 23 15:09:31 CST 2018
     */
    int updateByPrimaryKey(DrawCashOrder record);
}