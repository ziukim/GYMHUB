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
    int updateProfileImage(@Param("gymNo") int gymNo, @Param("photoPath") String photoPath);
    int updateGym(Gym gym);
}