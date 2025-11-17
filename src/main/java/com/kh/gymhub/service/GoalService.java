package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.MemberGoal;

import java.util.List;

public interface GoalService {
    List<MemberGoal> getGoalsByMember(int memberNo);
    MemberGoal addGoal(int memberNo, String goalTitle);
    boolean deleteGoal(int goalManageNo, int memberNo);
    boolean toggleGoalStatus(int goalManageNo, int memberNo);
}





