package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.PtReserveMapper;
import com.kh.gymhub.model.vo.PtReserve;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PtReserveServiceImpl implements PtReserveService {

    private final PtReserveMapper ptReserveMapper;

    @Autowired
    public PtReserveServiceImpl(PtReserveMapper ptReserveMapper) {
        this.ptReserveMapper = ptReserveMapper;
    }

    @Override
    public List<PtReserve> getPendingPtReservesByGymNo(int gymNo) {
        return ptReserveMapper.selectPendingPtReservesByGymNo(gymNo);
    }

    @Override
    public List<PtReserve> getApprovedOrRejectedPtReservesByGymNo(int gymNo) {
        return ptReserveMapper.selectApprovedOrRejectedPtReservesByGymNo(gymNo);
    }

    @Override
    public int approvePtReserve(int ptReserveNo, int ptTrainerNo) {
        return ptReserveMapper.updatePtReserveApprove(ptReserveNo, ptTrainerNo);
    }

    @Override
    public int rejectPtReserve(int ptReserveNo) {
        return ptReserveMapper.updatePtReserveReject(ptReserveNo);
    }

    @Override
    public PtReserve getPtReserveByNo(int ptReserveNo) {
        return ptReserveMapper.selectPtReserveByNo(ptReserveNo);
    }
}

