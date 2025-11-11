package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.YoutubeUrlMapper;
import com.kh.gymhub.model.vo.YoutubeUrl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class YoutubeUrlServiceImpl implements YoutubeUrlService {

    private final YoutubeUrlMapper youtubeUrlMapper;

    @Autowired
    public YoutubeUrlServiceImpl(YoutubeUrlMapper youtubeUrlMapper) {
        this.youtubeUrlMapper = youtubeUrlMapper;
    }

    @Override
    public List<YoutubeUrl> getYoutubeUrlsByGymNo(int gymNo) {
        return youtubeUrlMapper.getYoutubeUrlsByGymNo(gymNo);
    }

    @Override
    @Transactional
    public int addYoutubeUrl(YoutubeUrl youtubeUrl) {
        return youtubeUrlMapper.addYoutubeUrl(youtubeUrl);
    }

    @Override
    @Transactional
    public int deleteYoutubeUrl(int youtubeUrlNo) {
        return youtubeUrlMapper.deleteYoutubeUrl(youtubeUrlNo);
    }
}

