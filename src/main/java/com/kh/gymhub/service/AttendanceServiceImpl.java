package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.AttendanceMapper;
import com.kh.gymhub.model.vo.Attendance;
import com.kh.gymhub.model.vo.Member;
import org.springframework.stereotype.Service;

@Service
public class AttendanceServiceImpl implements AttendanceService {

    private final AttendanceMapper attendanceMapper;

    public AttendanceServiceImpl(AttendanceMapper attendanceMapper) {
        this.attendanceMapper = attendanceMapper;
    }

    @Override
    public Member getMemberByPhoneAndGymNo(String phone, int gymNo) {
        return attendanceMapper.selectMemberByPhoneAndGymNo(phone, gymNo);
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
}

