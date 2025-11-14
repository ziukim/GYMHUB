package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.AttendanceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AttendanceServiceImpl implements AttendanceService {

    private final AttendanceMapper attendanceMapper;

    @Autowired
    public AttendanceServiceImpl(AttendanceMapper attendanceMapper) {
        this.attendanceMapper = attendanceMapper;
    }

    @Override
    public Map<String, Object> getAttendanceStats(int memberNo, int gymNo) {
        return attendanceMapper.getAttendanceStats(memberNo, gymNo);
    }

    @Override
    public List<Map<String, Object>> getAttendanceList(int memberNo, int gymNo) {
        return attendanceMapper.getAttendanceList(memberNo, gymNo);
    }
}