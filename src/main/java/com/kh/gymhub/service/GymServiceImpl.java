package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.GymMapper;
import com.kh.gymhub.model.mapper.MemberMapper;
import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class GymServiceImpl implements GymService {

    private final GymMapper gymMapper;
    private final MemberMapper memberMapper;

    @Autowired
    public GymServiceImpl(GymMapper gymMapper, MemberMapper memberMapper) {
        this.gymMapper = gymMapper;
        this.memberMapper = memberMapper;
    }

    @Override
    @Transactional
    public int addGym(Gym gym) {
        return gymMapper.insertGym(gym);
    }

    @Override
    public Gym getGymByNo(int gymNo) {
        return gymMapper.selectGymByNo(gymNo);
    }

    @Override
    public List<Gym> getAllGyms() {
        return gymMapper.selectAllGyms();
    }

    @Override
    public List<Gym> getAllGymsWithSort(String sortType) {
        return gymMapper.selectAllGymsWithSort(sortType);
    }

    @Override
    @Transactional
    public int updateProfileImage(int gymNo, String photoPath) {
        return gymMapper.updateProfileImage(gymNo, photoPath);
    }

    @Override
    @Transactional
    public int updateGym(Gym gym) {
        return gymMapper.updateGym(gym);
    }

    @Override
    @Transactional
    public int withdrawGym(int gymNo) {
        // 1. 헬스장에 연결된 트레이너들의 GYM_NO를 NULL로 변경
        List<Member> trainers = memberMapper.selectTrainersByGymNo(gymNo);
        if (trainers != null && !trainers.isEmpty()) {
            for (Member trainer : trainers) {
                memberMapper.updateMemberGymNo(trainer.getMemberNo(), null);
            }
        }
        
        // 2. 헬스장 운영자의 STATUS를 'N'으로 변경
        Member gymOwner = memberMapper.selectGymOwnerByGymNo(gymNo);
        if (gymOwner != null) {
            memberMapper.withdrawMember(gymOwner.getMemberNo());
        }
        
        // 3. 헬스장 탈퇴 처리 (STATUS를 'N'으로 변경)
        return gymMapper.withdrawGym(gymNo);
    }

    @Override
    public int countRegularMembersByGymNo(int gymNo) {
        return memberMapper.countRegularMembersByGymNo(gymNo);
    }
}