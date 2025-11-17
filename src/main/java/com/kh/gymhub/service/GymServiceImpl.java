package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.GymMapper;
import com.kh.gymhub.model.vo.Gym;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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

    @Override
    public Gym getGymByNo(int gymNo) {
        return gymMapper.selectGymByNo(gymNo);
    }

    @Override
    public List<Gym> getAllGyms() {
        return gymMapper.selectAllGyms();
    }

    @Override
    public List<Gym> getAllGymsWithSort(String sortType) {
        return gymMapper.selectAllGymsWithSort(sortType);
    }

    @Override
    @Transactional
    public int updateProfileImage(int gymNo, String photoPath) {
        return gymMapper.updateProfileImage(gymNo, photoPath);
    }

    @Override
    @Transactional
    public int updateGym(Gym gym) {
        return gymMapper.updateGym(gym);
    }
}