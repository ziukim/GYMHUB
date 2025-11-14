package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Attendance;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface AttendanceMapper {
    // 출석 통계 데이터 조회
    Map<String, Object> getAttendanceStats(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);

    // 출석 목록 조회 (최근 순)
    List<Map<String, Object>> getAttendanceList(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);
}