package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.GymDetail;

public interface GymDetailService {
    GymDetail getGymDetailByGymNo(int gymNo);
    int addGymDetail(int gymNo);
    int updateGymDetail(GymDetail gymDetail);
}

