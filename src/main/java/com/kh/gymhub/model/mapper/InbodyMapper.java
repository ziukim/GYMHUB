package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.InbodyRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface InbodyMapper {
    int insertInbody(InbodyRecord inbody);
    List<InbodyRecord> selectInbodyList(@Param("memberNo") int memberNo);
    InbodyRecord selectLatestInbody(@Param("memberNo") int memberNo);
}