package com.kh.gymhub.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface DashboardMapper {
    Map<String, Object> selectMembershipInfo(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);
    Map<String, Object> selectAttendanceInfo(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);
    Map<String, Object> selectCongestionInfo(@Param("gymNo") int gymNo);
    Map<String, Object> selectGymInfo(@Param("gymNo") int gymNo);
    List<Map<String, Object>> selectNotices(@Param("gymNo") int gymNo);
    List<Map<String, Object>> selectVideos(@Param("gymNo") int gymNo);
    List<Map<String, Object>> selectAllVideos(@Param("gymNo") int gymNo);
    Map<String, Object> selectPtInfo(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);
}