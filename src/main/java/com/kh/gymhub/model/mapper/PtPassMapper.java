package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.PtPass;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PtPassMapper {
    int insertPtPass(PtPass ptPass);
}

