package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Gym;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GymMapper {
    int insertGym(Gym gym);
}