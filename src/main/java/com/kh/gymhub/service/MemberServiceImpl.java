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
        // This method seems to require more complex logic involving the Gym table,
        // which is outside the current scope. Providing a placeholder implementation.
        // 컨트롤러에서 암호화된 비밀번호를 전달하므로, 여기서는 암호화 로직이 필요 없습니다.
        // TODO: GymMapper를 사용하여 gym 정보도 함께 저장하는 로직 구현 필요
        return memberMapper.addMember(member);
    }

    @Override
    public Member login(String memberId, String memberPwd) {
        Member member = memberMapper.getMemberForLogin(memberId);
        if (member != null && bCryptPasswordEncoder.matches(memberPwd, member.getMemberPwd())) {
            return member;
        }
        return null;
    }

    @Override
    @Transactional
    public int updateMember(Member member) {
        return memberMapper.updateMember(member);
    }

    @Override
    @Transactional
    public int updatePassword(String memberId, String currentPwd, String newPwd) {
        Member member = memberMapper.getMemberById(memberId);
        if (member != null && bCryptPasswordEncoder.matches(currentPwd, member.getMemberPwd())) {
            String hashedNewPwd = bCryptPasswordEncoder.encode(newPwd);
            return memberMapper.updatePassword(memberId, hashedNewPwd);
        }
        return 0; // 0을 반환하여 현재 비밀번호 불일치 또는 유저 없음 오류를 알림
    }
}
