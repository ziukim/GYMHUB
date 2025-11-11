package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.YoutubeUrl;

import java.util.List;

public interface YoutubeUrlService {
    List<YoutubeUrl> getYoutubeUrlsByGymNo(int gymNo);
    int addYoutubeUrl(YoutubeUrl youtubeUrl);
    int deleteYoutubeUrl(int youtubeUrlNo);
}

