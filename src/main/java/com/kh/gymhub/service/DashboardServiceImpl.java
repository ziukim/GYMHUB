package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.DashboardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class DashboardServiceImpl implements DashboardService {

    private final DashboardMapper dashboardMapper;


    @Autowired
    public DashboardServiceImpl(DashboardMapper dashboardMapper) {
        this.dashboardMapper = dashboardMapper;
    }

    @Override
    public Map<String, Object> getDashboardData(int memberNo, int gymNo) {
        Map<String, Object> result = new HashMap<>();

        result.put("membership", dashboardMapper.selectMembershipInfo(memberNo, gymNo));
        result.put("attendance", dashboardMapper.selectAttendanceInfo(memberNo, gymNo));
        result.put("congestion", dashboardMapper.selectCongestionInfo(gymNo));
        result.put("gymInfo", dashboardMapper.selectGymInfo(gymNo));
        result.put("notices", dashboardMapper.selectNotices(gymNo));
        result.put("videos", dashboardMapper.selectVideos(gymNo));
        result.put("allVideos", dashboardMapper.selectAllVideos(gymNo));
        result.put("ptInfo", dashboardMapper.selectPtInfo(memberNo, gymNo));

        return result;
    }

}