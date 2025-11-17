package com.kh.gymhub.service;

import java.util.List;
import java.util.Map;

public interface DashboardService {
    Map<String, Object> getDashboardData(int memberNo, int gymNo);
    Map<String, Object> getNoticeDetail(int noticeNo);
}