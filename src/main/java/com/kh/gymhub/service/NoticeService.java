package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.GymNotice;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface NoticeService {
    List<GymNotice> getNoticesByGymNo(int gymNo);
    List<GymNotice> getLatestNoticesByGymNo(int gymNo);
    GymNotice getNoticeByNo(int noticeNo);
    int insertNotice(GymNotice notice, MultipartFile file);
    int updateNotice(GymNotice notice, MultipartFile file);
    int updateNoticeFixStatus(int noticeNo, String fixStatus);
    int deleteNotice(int noticeNo);
}

