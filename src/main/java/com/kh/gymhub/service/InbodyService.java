package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.InbodyRecord;
import java.util.List;

public interface InbodyService {
    int insertInbody(InbodyRecord inbody);
    List<InbodyRecord> getInbodyList(int memberNo);
    InbodyRecord getLatestInbody(int memberNo);
}