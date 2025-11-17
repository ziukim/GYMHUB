package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.AttendanceMapper;
import com.kh.gymhub.model.vo.Attendance;
import com.kh.gymhub.model.vo.Member;
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

    @Override
    public Member getMemberByPhoneAndGymNo(String phone, int gymNo) {
        return attendanceMapper.selectMemberByPhoneAndGymNo(phone, gymNo);
    }

    @Override
    public Member getTrainerByPhoneAndGymNo(String phone, int gymNo) {
        return attendanceMapper.selectTrainerByPhoneAndGymNo(phone, gymNo);
    }

    @Override
    public Attendance getTodayCheckIn(int gymNo, int memberNo) {
        return attendanceMapper.selectTodayCheckIn(gymNo, memberNo);
    }

    @Override
    public Attendance getTodayCheckOut(int gymNo, int memberNo) {
        return attendanceMapper.selectTodayCheckOut(gymNo, memberNo);
    }

    @Override
    public int insertAttendance(Attendance attendance) {
        return attendanceMapper.insertAttendance(attendance);
    }

    @Override
    public Integer getTodayAttendanceCountByGymNo(int gymNo) {
        return attendanceMapper.selectTodayAttendanceCountByGymNo(gymNo);
    }

}