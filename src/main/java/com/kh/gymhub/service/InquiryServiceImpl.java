package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.InquiryMapper;
import com.kh.gymhub.model.vo.InquiryReserve;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InquiryServiceImpl implements InquiryService {

    private final InquiryMapper inquiryMapper;

    public InquiryServiceImpl(InquiryMapper inquiryMapper) {
        this.inquiryMapper = inquiryMapper;
    }

    @Override
    public List<InquiryReserve> getApprovedFutureReservationsByGymNo(int gymNo) {
        return inquiryMapper.selectApprovedFutureReservationsByGymNo(gymNo);
    }

    @Override
    public List<InquiryReserve> getReservedInquiriesByGymNo(int gymNo) {
        return inquiryMapper.selectReservedInquiriesByGymNo(gymNo);
    }

    @Override
    public int updateInquiryStatusToCompleted(int inquiryNo) {
        return inquiryMapper.updateInquiryStatusToCompleted(inquiryNo);
    }
}

