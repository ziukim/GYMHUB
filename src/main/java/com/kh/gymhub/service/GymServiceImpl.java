package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.GymMapper;
import com.kh.gymhub.model.vo.Gym;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class GymServiceImpl implements GymService {

    private final GymMapper gymMapper;

    @Autowired
    public GymServiceImpl(GymMapper gymMapper) {
        this.gymMapper = gymMapper;
    }

    @Override
    @Transactional
    public int addGym(Gym gym) {
        return gymMapper.insertGym(gym);
    }
}