package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.YoutubeUrl;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface YoutubeUrlMapper {
    List<YoutubeUrl> getYoutubeUrlsByGymNo(@Param("gymNo") int gymNo);
    int addYoutubeUrl(YoutubeUrl youtubeUrl);
    int deleteYoutubeUrl(@Param("youtubeUrlNo") int youtubeUrlNo);
}

