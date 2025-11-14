package com.kh.gymhub.service;

import java.util.List;
import java.util.Map;

public interface AttendanceService {
    Map<String, Object> getAttendanceStats(int memberNo, int gymNo);
    List<Map<String, Object>> getAttendanceList(int memberNo, int gymNo);
}