package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.MemberMapper;
import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final GymService gymService;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper,
                             BCryptPasswordEncoder bCryptPasswordEncoder,
                             GymService gymService) {
        this.memberMapper = memberMapper;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.gymService = gymService;
    }

    @Override
    public Member getMemberById(String memberId) {
        return memberMapper.getMemberById(memberId);
    }

    @Override
    public int getMemberCountById(String memberId) {
        return memberMapper.getMemberCountById(memberId);
    }

    @Override
    @Transactional
    public int addMember(Member member) {
        return memberMapper.addMember(member);
    }

    @Override
    @Transactional
    public int addGymOwner(Member member, Gym gym) {
        // memberType=3(헬스장 운영자)인지 검증
        if (member.getMemberType() != 3) {
            throw new IllegalArgumentException("헬스장 운영자만 GYM 테이블에 등록할 수 있습니다.");
        }

        // 1. GYM 테이블에 먼저 INSERT (GYM_NO 생성)
        int gymResult = gymService.addGym(gym);

        if (gymResult > 0) {
            // 2. 생성된 GYM_NO를 Member에 설정
            member.setGymNo(gym.getGymNo());

            // 3. MEMBER 테이블에 INSERT
            int memberResult = memberMapper.addMember(member);

            return memberResult;
        }

        return 0;
    }

    @Override
    public Member login(String memberId, String memberPwd) {
        Member member = memberMapper.getMemberForLogin(memberId);

        if (member != null && bCryptPasswordEncoder.matches(memberPwd, member.getMemberPwd())) {
            return member;
        }

        return null;
    }
}