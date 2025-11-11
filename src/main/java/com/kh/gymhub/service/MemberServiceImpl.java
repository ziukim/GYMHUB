package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.MemberMapper;
import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

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
        // 컨트롤러에서 이미 암호화된 비밀번호를 전달하므로, 여기서는 암호화 로직을 제거합니다.
        return memberMapper.addMember(member);
    }

    @Override
    @Transactional
    public int addGymOwner(Member member, Gym gym) {
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
        // 로그인 전용 쿼리로 회원 정보 조회
        Member member = memberMapper.getMemberForLogin(memberId);

        // 회원이 존재하고 비밀번호가 일치하는지 확인
        if (member != null && bCryptPasswordEncoder.matches(memberPwd, member.getMemberPwd())) {
            return member;
        }
        return null;
    }

    @Override
    @Transactional
    public int updateMemberInfo(Member member) {
        return memberMapper.updateMemberInfo(member);
    }

    @Override
    @Transactional
    public int updatePassword(int memberNo, String newPassword) {
        return memberMapper.updatePassword(memberNo, newPassword);
    }
}
