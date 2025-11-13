package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.Gym;
import java.util.List;

public interface GymService {
    int addGym(Gym gym);
    Gym getGymByNo(int gymNo);
    List<Gym> getAllGyms();
    int updateProfileImage(int gymNo, String photoPath);
    int updateGym(Gym gym);
}