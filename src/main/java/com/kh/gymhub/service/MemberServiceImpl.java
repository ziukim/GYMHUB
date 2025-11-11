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
        member.setMemberPwd(bCryptPasswordEncoder.encode(member.getMemberPwd()));
        return memberMapper.addMember(member);
    }

    @Override
    @Transactional
    public int addGymOwner(Member member, Gym gym) {
        // This method seems to require more complex logic involving the Gym table,
        // which is outside the current scope. Providing a placeholder implementation.
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
