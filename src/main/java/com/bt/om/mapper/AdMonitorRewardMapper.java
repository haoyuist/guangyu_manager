package com.bt.om.mapper;

import com.bt.om.entity.AdMonitorReward;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdMonitorRewardMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table ad_monitor_reward
     *
     * @mbggenerated Fri Jan 26 14:10:24 CST 2018
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table ad_monitor_reward
     *
     * @mbggenerated Fri Jan 26 14:10:24 CST 2018
     */
    int insert(AdMonitorReward record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table ad_monitor_reward
     *
     * @mbggenerated Fri Jan 26 14:10:24 CST 2018
     */
    int insertSelective(AdMonitorReward record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table ad_monitor_reward
     *
     * @mbggenerated Fri Jan 26 14:10:24 CST 2018
     */
    AdMonitorReward selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table ad_monitor_reward
     *
     * @mbggenerated Fri Jan 26 14:10:24 CST 2018
     */
    int updateByPrimaryKeySelective(AdMonitorReward record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table ad_monitor_reward
     *
     * @mbggenerated Fri Jan 26 14:10:24 CST 2018
     */
    int updateByPrimaryKey(AdMonitorReward record);

    List<AdMonitorReward> selectByUserId(@Param("userId") Integer userId);

    int selectTotalRewardByUserId(@Param("userId") Integer userId);
}