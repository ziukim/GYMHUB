package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.InbodyMapper;
import com.kh.gymhub.model.vo.InbodyRecord;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class InbodyServiceImpl implements InbodyService {

    private final InbodyMapper inbodyMapper;

    public InbodyServiceImpl(InbodyMapper inbodyMapper) {
        this.inbodyMapper = inbodyMapper;
    }

    @Override
    @Transactional
    public int insertInbody(InbodyRecord inbody) {
        return inbodyMapper.insertInbody(inbody);
    }

    @Override
    public List<InbodyRecord> getInbodyList(int memberNo) {
        return inbodyMapper.selectInbodyList(memberNo);
    }

    @Override
    public InbodyRecord getLatestInbody(int memberNo) {
        return inbodyMapper.selectLatestInbody(memberNo);
    }
}