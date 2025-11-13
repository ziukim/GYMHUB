package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.GymDetail;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface GymDetailMapper {
    GymDetail selectGymDetailByGymNo(@Param("gymNo") int gymNo);
    int insertGymDetail(GymDetail gymDetail);
    int updateGymDetail(GymDetail gymDetail);
    int addGymDetail(@Param("gymNo") int gymNo);
}

