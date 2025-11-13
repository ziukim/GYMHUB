package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.GymDetailMapper;
import com.kh.gymhub.model.vo.GymDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class GymDetailServiceImpl implements GymDetailService {

    private final GymDetailMapper gymDetailMapper;

    @Autowired
    public GymDetailServiceImpl(GymDetailMapper gymDetailMapper) {
        this.gymDetailMapper = gymDetailMapper;
    }

    @Override
    public GymDetail getGymDetailByGymNo(int gymNo) {
        return gymDetailMapper.selectGymDetailByGymNo(gymNo);
    }

    @Override
    @Transactional
    public int addGymDetail(int gymNo) {
        return gymDetailMapper.addGymDetail(gymNo);
    }

    @Override
    @Transactional
    public int updateGymDetail(GymDetail gymDetail) {
        return gymDetailMapper.updateGymDetail(gymDetail);
    }
}

