package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Gym;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface GymMapper {
    int insertGym(Gym gym);
    Gym selectGymByNo(@Param("gymNo") int gymNo);
    List<Gym> selectAllGyms();

    /**
     * 1개월 회원권 가격 기준으로 정렬된 헬스장 목록 조회
     * @param sortType "price-low" (가격 낮은 순) 또는 "price-high" (가격 높은 순)
     * @return 정렬된 헬스장 목록
     */
    List<Gym> selectAllGymsWithSort(@Param("sortType") String sortType);

    int updateProfileImage(@Param("gymNo") int gymNo, @Param("photoPath") String photoPath);
    int updateGym(Gym gym);
}