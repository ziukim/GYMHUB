package com.kh.gymhub.service;

import java.util.Map;

public interface DashboardService {
    Map<String, Object> getDashboardData(int memberNo, int gymNo);
}