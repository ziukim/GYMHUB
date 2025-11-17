package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.GoalMapper;
import com.kh.gymhub.model.vo.MemberGoal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class GoalServiceImpl implements GoalService {

    private final GoalMapper goalMapper;

    @Autowired
    public GoalServiceImpl(GoalMapper goalMapper) {
        this.goalMapper = goalMapper;
    }

    @Override
    public List<MemberGoal> getGoalsByMember(int memberNo) {
        return goalMapper.selectMemberGoals(memberNo);
    }

    @Override
    @Transactional
    public MemberGoal addGoal(int memberNo, String goalTitle) {
        if (goalTitle == null || goalTitle.trim().isEmpty()) {
            throw new IllegalArgumentException("목표를 입력해주세요.");
        }

        MemberGoal newGoal = MemberGoal.builder()
                .memberNo(memberNo)
                .goalTitle(goalTitle.trim())
                .goalStatus("미달성")
                .build();

        int insertedGoal = goalMapper.insertGoal(newGoal);
        if (insertedGoal <= 0) {
            throw new RuntimeException("목표 저장에 실패했습니다.");
        }

        int insertedManage = goalMapper.insertGoalManage(newGoal);
        if (insertedManage <= 0) {
            throw new RuntimeException("목표 관리 기록 저장에 실패했습니다.");
        }

        return goalMapper.selectGoalByManageNo(newGoal.getGoalManageNo());
    }

    @Override
    @Transactional
    public boolean deleteGoal(int goalManageNo, int memberNo) {
        // 1. goalManageNo로 goalNo 조회
        Integer goalNo = goalMapper.selectGoalNoByManageNo(goalManageNo);
        if (goalNo == null) {
            return false;
        }

        // 2. GOAL_MANAGE 삭제 (본인 소유 확인)
        int deletedCount = goalMapper.deleteGoalManage(goalManageNo, memberNo);
        if (deletedCount <= 0) {
            return false;
        }

        // 3. 해당 GOAL_NO를 참조하는 다른 GOAL_MANAGE가 있는지 확인
        int remainingCount = goalMapper.countGoalManageByGoalNo(goalNo);
        if (remainingCount == 0) {
            // 다른 참조가 없으면 GOAL 테이블에서도 삭제
            goalMapper.deleteGoal(goalNo);
        }

        return true;
    }

    @Override
    @Transactional
    public boolean toggleGoalStatus(int goalManageNo, int memberNo) {
        MemberGoal goal = goalMapper.selectGoalByManageNo(goalManageNo);
        if (goal == null || goal.getMemberNo() != memberNo) {
            return false;
        }

        String newStatus = "미달성".equals(goal.getGoalStatus()) ? "달성" : "미달성";

        return goalMapper.updateGoalStatus(goal.getGoalNo(), newStatus) > 0;
    }
}





