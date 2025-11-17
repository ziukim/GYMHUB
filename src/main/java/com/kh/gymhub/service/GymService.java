package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.Gym;

import java.util.List;

public interface GymService {
    int addGym(Gym gym);
    Gym getGymByNo(int gymNo);
    List<Gym> getAllGyms();

    /**
     * 1개월 회원권 가격 기준으로 정렬된 헬스장 목록 조회
     * @param sortType "price-low" (가격 낮은 순) 또는 "price-high" (가격 높은 순)
     * @return 정렬된 헬스장 목록
     */
    List<Gym> getAllGymsWithSort(String sortType);

    int updateProfileImage(int gymNo, String photoPath);
    int updateGym(Gym gym);
}