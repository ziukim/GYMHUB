package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.GymNotice;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface NoticeMapper {
    List<GymNotice> selectNoticesByGymNo(@Param("gymNo") int gymNo);
    List<GymNotice> selectLatestNoticesByGymNo(@Param("gymNo") int gymNo);
    GymNotice selectNoticeByNo(@Param("noticeNo") int noticeNo);
    int insertNotice(GymNotice notice);
    int updateNotice(GymNotice notice);
    int updateNoticeFixStatus(@Param("noticeNo") int noticeNo, @Param("fixStatus") String fixStatus);
    int deleteNotice(@Param("noticeNo") int noticeNo);
}

