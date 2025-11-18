package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.PtPass;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PtPassMapper {
    int insertPtPass(PtPass ptPass);
    
    // 회원번호로 PT 이용권 조회
    PtPass selectPtPassByMemberNo(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);
    
    // PT 이용권 횟수 추가
    int updatePtPassCount(@Param("ptPassNo") int ptPassNo, @Param("additionalCount") int additionalCount);
    
    // 회원 삭제 시 PT 이용권 만료 처리
    int expirePtPassesByMemberNo(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);
}

