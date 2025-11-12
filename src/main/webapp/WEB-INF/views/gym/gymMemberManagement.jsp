<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 회원 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* main-content 가로로 가득 차게 - !important로 common.css 오버라이드 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px 24px 24px 24px !important;
            margin-right: 0 !important;
        }

        .content-container {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        /* Header */
        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 16px;
            border-bottom: 2px solid #ff6b00;
            margin-bottom: 24px;
        }

        .header-info h2 {
            font-size: 18px;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .header-info p {
            font-size: 12px;
            color: #b0b0b0;
        }

        .header-buttons {
            display: flex;
            gap: 8px;
        }

        .filter-btn {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 10px 16px;
            color: white;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.25);
        }

        .filter-btn:hover {
            background-color: #ff6b00;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.5);
        }

        .add-member-btn {
            background-color: #ff6b00;
            border: none;
            border-radius: 8px;
            padding: 10px 16px;
            color: white;
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
        }

        .add-member-btn:hover {
            box-shadow: 0 0 25px rgba(255, 107, 0, 0.6);
            transform: translateY(-2px);
        }

        /* Table */
        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background-color: #2d1810;
        }

        th {
            text-align: left;
            padding: 11px 16px;
            color: #ff6b00;
            font-size: 14px;
            font-weight: 700;
            border-bottom: 2px solid #ff6b00;
        }

        th:last-child {
            text-align: center;
        }

        td {
            padding: 13px 16px;
            color: #b0b0b0;
            font-size: 14px;
            border-bottom: 1px solid #3a3a3a;
        }

        td:first-child {
            color: white;
            font-size: 16px;
        }

        td:nth-child(2) {
            color: #ffa366;
        }

        /* Status Badge */
        .status-badge {
            display: inline-block;
            padding: 5px 13px;
            border-radius: 20px;
            font-size: 12px;
        }

        .status-normal {
            background-color: rgba(0, 201, 80, 0.2);
            border: 1px solid #00c950;
            color: #05df72;
        }

        .status-expiring {
            background-color: rgba(240, 177, 0, 0.2);
            border: 1px solid #f0b100;
            color: #fdc700;
        }

        .status-expired {
            background-color: rgba(251, 44, 54, 0.2);
            border: 1px solid #fb2c36;
            color: #ff6467;
        }

        .status-new {
            background-color: rgba(255, 107, 0, 0.2);
            border: 1px solid #ff6b00;
            color: #ff6b00;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
            justify-content: center;
        }

        .edit-btn {
            background-color: #0a0a0a;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            padding: 6px 0;
            width: 54px;
            color: #ffa366;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .edit-btn:hover {
            background-color: #ff6b00;
            color: white;
        }

        .delete-btn {
            background-color: #0a0a0a;
            border: 1px solid #ff5252;
            border-radius: 8px;
            padding: 6px 0;
            width: 54px;
            color: #ff5252;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .delete-btn:hover {
            background-color: #ff5252;
            color: white;
        }

        /* Modal */
        .modal {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            width: 90%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.5);
        }

        .modal-header {
            padding: 24px;
            border-bottom: 1px solid #ff6b00;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .modal-title-section h2 {
            font-size: 20px;
            color: #ff6b00;
            margin-bottom: 8px;
            font-weight: 700;
        }

        .modal-title-section p {
            font-size: 13px;
            color: #b0b0b0;
        }

        .modal-close-btn {
            background: transparent;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            transition: background 0.2s;
        }

        .modal-close-btn:hover {
            background: rgba(255, 107, 0, 0.2);
        }

        .modal-body {
            padding: 24px;
        }

        .modal-form-group {
            margin-bottom: 20px;
        }

        .modal-form-group label {
            display: block;
            color: white;
            font-size: 14px;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .modal-form-group label .required {
            color: #ff5252;
        }

        .modal-input-group {
            display: flex;
            gap: 8px;
            align-items: flex-start;
        }

        .modal-input {
            flex: 1;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            padding: 12px 16px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .modal-input:focus {
            outline: none;
            border-color: #ffa366;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.3);
        }

        .modal-input::placeholder {
            color: #666;
        }

        /* 날짜 입력 필드 스타일 */
        .modal-input[type="date"] {
            color: white;
            color-scheme: dark;
        }

        .modal-input[type="date"]::-webkit-calendar-picker-indicator {
            filter: invert(1) sepia(1) saturate(5) hue-rotate(345deg);
            cursor: pointer;
            opacity: 0.9;
        }

        .modal-input[type="date"]::-webkit-calendar-picker-indicator:hover {
            opacity: 1;
        }

        /* 읽기 전용 날짜 필드 스타일 */
        .modal-input[readonly] {
            background-color: #1a0f0a;
            cursor: not-allowed;
            color: white !important;
            opacity: 1;
        }

        .modal-input[readonly]::-webkit-calendar-picker-indicator {
            display: none;
            pointer-events: none;
        }

        /* Firefox용 */
        .modal-input[readonly]::-moz-calendar-picker-indicator {
            display: none;
            pointer-events: none;
        }

        .modal-btn {
            background-color: #ff6b00;
            border: none;
            border-radius: 8px;
            padding: 12px 20px;
            color: white;
            font-size: 14px;
            cursor: pointer;
            white-space: nowrap;
            transition: all 0.3s;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .modal-btn:hover {
            background-color: #ff8500;
            box-shadow: 0 0 12px rgba(255, 107, 0, 0.4);
        }

        .modal-btn-secondary {
            background-color: transparent;
            border: 1px solid #ff6b00;
        }

        .modal-btn-secondary:hover {
            background-color: rgba(255, 107, 0, 0.1);
        }

        .modal-date-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
        }

        .modal-date-row .modal-input {
            min-width: 220px;
            width: 100%;
        }

        .modal-footer {
            padding: 24px;
            border-top: 1px solid #ff6b00;
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }

        .modal-footer-btn {
            padding: 12px 32px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Noto Sans KR', sans-serif;
            border: none;
        }

        .modal-footer-btn-cancel {
            background-color: transparent;
            border: 1px solid #8a6a50;
            color: #8a6a50;
        }

        .modal-footer-btn-cancel:hover {
            background-color: rgba(138, 106, 80, 0.1);
        }

        .modal-footer-btn-submit {
            background-color: #ff6b00;
            color: white;
            font-weight: 600;
        }

        .modal-footer-btn-submit:hover {
            background-color: #ff8500;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
        }

        .modal-display-field {
            flex: 1;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            padding: 12px 16px;
            color: white;
            font-size: 14px;
            min-height: 44px;
            display: flex;
            align-items: center;
        }

        /* 회원 프로필 카드 */
        .member-profile-card {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            padding: 20px;
            margin-top: 16px;
            margin-bottom: 16px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        .profile-card-header {
            display: flex;
            align-items: center;
            gap: 16px;
            padding-bottom: 16px;
            border-bottom: 1px solid #ff6b0066;
            margin-bottom: 16px;
        }

        .profile-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            overflow: hidden;
            border: 2px solid #ff6b00;
            flex-shrink: 0;
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-info {
            flex: 1;
        }

        .profile-name {
            font-size: 18px;
            font-weight: bold;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .profile-id {
            font-size: 14px;
            color: #ffa366;
        }

        .profile-card-body {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .profile-detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .profile-label {
            font-size: 14px;
            color: #ffa366;
            min-width: 80px;
        }

        .profile-value {
            font-size: 14px;
            color: #ffffff;
            text-align: right;
            flex: 1;
        }

        /* 등록 확정 모달 */
        .confirm-modal {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            width: 90%;
            max-width: 500px;
            position: relative;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.5);
        }

        .confirm-modal-header {
            padding: 24px;
            border-bottom: 1px solid #ff6b00;
            text-align: center;
        }

        .confirm-modal-header h2 {
            font-size: 20px;
            color: #ff6b00;
            margin-bottom: 8px;
            font-weight: 700;
        }

        .confirm-modal-header p {
            font-size: 13px;
            color: #b0b0b0;
        }

        .confirm-modal-body {
            padding: 24px;
        }

        .confirm-profile-card {
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .confirm-profile-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 16px;
        }

        .confirm-profile-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            overflow: hidden;
            border: 2px solid #ff6b00;
            flex-shrink: 0;
        }

        .confirm-profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .confirm-profile-info {
            flex: 1;
        }

        .confirm-profile-name {
            font-size: 18px;
            font-weight: bold;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .confirm-profile-id {
            font-size: 14px;
            color: #ffa366;
        }

        .confirm-profile-details {
            display: flex;
            flex-direction: column;
            gap: 10px;
            border-top: 1px solid #ff6b0066;
            padding-top: 16px;
        }

        .confirm-detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .confirm-detail-label {
            font-size: 14px;
            color: #ffa366;
        }

        .confirm-detail-value {
            font-size: 14px;
            color: #ffffff;
            text-align: right;
        }

        .confirm-message {
            text-align: center;
            font-size: 14px;
            color: #b0b0b0;
            margin-top: 16px;
        }

        .confirm-modal-footer {
            padding: 24px;
            border-top: 1px solid #ff6b00;
            display: flex;
            gap: 12px;
            justify-content: center;
        }

        .confirm-modal-btn {
            padding: 12px 32px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Noto Sans KR', sans-serif;
            border: none;
        }

        .confirm-modal-btn-cancel {
            background-color: transparent;
            border: 1px solid #8a6a50;
            color: #8a6a50;
        }

        .confirm-modal-btn-cancel:hover {
            background-color: rgba(138, 106, 80, 0.1);
        }

        .confirm-modal-btn-confirm {
            background-color: #ff6b00;
            color: white;
            font-weight: 600;
        }

        .confirm-modal-btn-confirm:hover {
            background-color: #ff8500;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
        }

        /* 이용권 선택 모달 */
        .membership-select-modal {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            width: 90%;
            max-width: 500px;
            position: relative;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.5);
        }

        .membership-select-header {
            padding: 24px;
            border-bottom: 1px solid #ff6b00;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .membership-select-header h2 {
            font-size: 20px;
            color: #ff6b00;
            font-weight: 700;
        }

        .membership-select-close-btn {
            background: transparent;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            transition: background 0.2s;
        }

        .membership-select-close-btn:hover {
            background: rgba(255, 107, 0, 0.2);
        }

        .membership-select-body {
            padding: 24px;
        }

        .membership-option {
            margin-bottom: 24px;
        }

        .membership-option:last-child {
            margin-bottom: 0;
        }

        .membership-checkbox-wrapper {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .membership-checkbox {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: #ff6b00;
        }

        .membership-label {
            font-size: 16px;
            color: white;
            font-weight: 500;
        }

        .membership-dropdown-wrapper {
            margin-left: 32px;
        }

        .membership-dropdown {
            width: 100%;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            padding: 12px 16px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            cursor: pointer;
            transition: all 0.3s;
        }

        .membership-dropdown:focus {
            outline: none;
            border-color: #ffa366;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.3);
        }

        .membership-dropdown:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .membership-select-footer {
            padding: 24px;
            border-top: 1px solid #ff6b00;
            display: flex;
            gap: 12px;
            justify-content: center;
        }

        .membership-select-btn {
            padding: 12px 32px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Noto Sans KR', sans-serif;
            border: none;
        }

        .membership-select-btn-cancel {
            background-color: transparent;
            border: 1px solid #8a6a50;
            color: #8a6a50;
        }

        .membership-select-btn-cancel:hover {
            background-color: rgba(138, 106, 80, 0.1);
        }

        .membership-select-btn-confirm {
            background-color: #ff6b00;
            color: white;
            font-weight: 600;
        }

        .membership-select-btn-confirm:hover {
            background-color: #ff8500;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
        }

        /* 락커 조회 모달 */
        .locker-select-modal {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            width: 90%;
            max-width: 450px;
            max-height: 80vh;
            position: relative;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.5);
            display: flex;
            flex-direction: column;
        }

        .locker-select-header {
            padding: 24px;
            border-bottom: 1px solid #ff6b00;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-shrink: 0;
        }

        .locker-select-header h2 {
            font-size: 20px;
            color: #ff6b00;
            font-weight: 700;
            border-bottom: 2px solid #ff6b00;
            padding-bottom: 4px;
            display: inline-block;
        }

        .locker-select-close-btn {
            background: transparent;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            transition: background 0.2s;
        }

        .locker-select-close-btn:hover {
            background: rgba(255, 107, 0, 0.2);
        }

        .locker-select-body {
            padding: 24px;
            overflow-y: auto;
            flex: 1;
        }

        .locker-list {
            display: flex;
            flex-direction: column;
            gap: 0;
        }

        .locker-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 0;
            border-bottom: 1px solid #3a3a3a;
            color: white;
        }

        .locker-item:last-child {
            border-bottom: none;
        }

        .locker-number {
            font-size: 16px;
            color: white;
            font-weight: 500;
        }

        .locker-assign-btn {
            background-color: transparent;
            border: 1px solid #ff6b00;
            border-radius: 6px;
            padding: 8px 20px;
            color: #ff6b00;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .locker-assign-btn:hover {
            background-color: #ff6b00;
            color: white;
        }

        /* 달력 팝업 스타일 */
        .calendar-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.7);
            display: flex;
            justify-content: center;
            align-items: center;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s;
            z-index: 1100;
        }

        .calendar-overlay.show {
            opacity: 1;
            visibility: visible;
        }

        .calendar-popup {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            padding: 24px;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.5);
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .calendar-nav-btn {
            background-color: transparent;
            border: 1px solid #ff6b00;
            color: #ff6b00;
            width: 36px;
            height: 36px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .calendar-nav-btn:hover {
            background-color: #ff6b00;
            color: white;
        }

        .calendar-month {
            font-size: 18px;
            font-weight: bold;
            color: #ff6b00;
        }

        .calendar-weekdays {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 8px;
            margin-bottom: 12px;
        }

        .calendar-weekday {
            text-align: center;
            font-size: 14px;
            color: #ffa366;
            font-weight: 500;
            padding: 8px 0;
        }

        .calendar-days {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 8px;
        }

        .calendar-day {
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            color: white;
            transition: all 0.3s;
            border: 1px solid transparent;
        }

        .calendar-day:hover:not(.disabled):not(.empty) {
            background-color: rgba(255, 107, 0, 0.2);
            border-color: #ff6b00;
        }

        .calendar-day.selected {
            background-color: #ff6b00;
            color: white;
            font-weight: bold;
        }

        .calendar-day.disabled {
            color: #666;
            cursor: not-allowed;
            opacity: 0.3;
        }

        .calendar-day.empty {
            cursor: default;
        }

        .calendar-close-btn {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            background-color: #ff6b00;
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .calendar-close-btn:hover {
            background-color: #ff8500;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
        }

        /* 날짜 입력 필드 공통 스타일 */
        .date-input-field {
            flex: 1;
            background-color: #2d1810;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            padding: 12px 16px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            cursor: pointer;
            width: 100%;
        }

        .date-input-field:focus {
            outline: none;
            border-color: #ffa366;
            box-shadow: 0 0 8px rgba(255, 107, 0, 0.3);
        }

        .date-input-field::placeholder {
            color: #666;
        }

        /* ✅ 모달 z-index 우선순위 설정 */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-overlay.active {
            display: flex;
        }

        #membershipSelectModal {
            z-index: 1100;
        }

        #lockerSelectModal {
            z-index: 1100;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .main-content {
                width: 100% !important;
                margin-left: 0 !important;
            }
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="../common/sidebar/sidebarGym.jsp" />

    <!-- Main Content Area -->
    <div class="main-content">
        <div class="page-intro">
            <h1>회원 관리</h1>
            <p>헬스장의 회원정보를 확인하고 관리하세요</p>
        </div>
        <div class="content-container">
            <!-- Header -->
            <div class="content-header">
                <div class="header-info">
                    <h2>회원 목록</h2>
                    <p>전체 8명</p>
                </div>
                <div class="header-buttons">
                    <button class="filter-btn" onclick="filterMembers('all')">전체</button>
                    <button class="filter-btn" onclick="filterMembers('new')">신규</button>
                    <button class="filter-btn" onclick="filterMembers('expiring')">만료예정</button>
                    <button class="filter-btn" onclick="filterMembers('expired')">만료</button>
                    <button class="add-member-btn" onclick="addMember()">
                        <span>+</span>
                        <span>신규 회원 등록</span>
                    </button>
                </div>
            </div>

            <!-- Table -->
            <div class="table-container">
                <table id="memberTable">
                    <thead>
                    <tr>
                        <th>이름</th>
                        <th>이용권</th>
                        <th>시작일</th>
                        <th>만료일</th>
                        <th>락커</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr data-status="normal">
                        <td>김회원</td>
                        <td>30일 이용권 + 30일 락커 이용권 + PT 10회 이용권</td>
                        <td>2024.04.01</td>
                        <td>2025.04.01</td>
                        <td>A-127</td>
                        <td><span class="status-badge status-normal">정상</span></td>
                        <td>
                            <div class="action-buttons">
                                <button class="edit-btn" onclick="editMember(this)">수정</button>
                                <button class="delete-btn" onclick="deleteMember(this)">삭제</button>
                            </div>
                        </td>
                    </tr>
                    <tr data-status="expiring">
                        <td>이회원</td>
                        <td>30일 이용권 + 30일 락커 이용권 + PT 10회 이용권</td>
                        <td>2024.09.15</td>
                        <td>2024.12.15</td>
                        <td>B-45</td>
                        <td><span class="status-badge status-expiring">만료임박</span></td>
                        <td>
                            <div class="action-buttons">
                                <button class="edit-btn" onclick="editMember(this)">수정</button>
                                <button class="delete-btn" onclick="deleteMember(this)">삭제</button>
                            </div>
                        </td>
                    </tr>
                    <tr data-status="normal">
                        <td>박서준</td>
                        <td>30일 이용권 + 30일 락커 이용권 + PT 10회 이용권</td>
                        <td>2024.08.01</td>
                        <td>2024.11.01</td>
                        <td>-</td>
                        <td><span class="status-badge status-normal">정상</span></td>
                        <td>
                            <div class="action-buttons">
                                <button class="edit-btn" onclick="editMember(this)">수정</button>
                                <button class="delete-btn" onclick="deleteMember(this)">삭제</button>
                            </div>
                        </td>
                    </tr>
                    <tr data-status="expired">
                        <td>최유진</td>
                        <td>30일 이용권 + 30일 락커 이용권 + PT 10회 이용권</td>
                        <td>2024.06.10</td>
                        <td>2024.09.10</td>
                        <td>A-89</td>
                        <td><span class="status-badge status-expired">만료</span></td>
                        <td>
                            <div class="action-buttons">
                                <button class="edit-btn" onclick="editMember(this)">수정</button>
                                <button class="delete-btn" onclick="deleteMember(this)">삭제</button>
                            </div>
                        </td>
                    </tr>
                    <tr data-status="new">
                        <td>정수연</td>
                        <td>30일 이용권 + 30일 락커 이용권 + PT 10회 이용권</td>
                        <td>2024.10.01</td>
                        <td>2025.01.01</td>
                        <td>C-12</td>
                        <td><span class="status-badge status-new">신규</span></td>
                        <td>
                            <div class="action-buttons">
                                <button class="edit-btn" onclick="editMember(this)">수정</button>
                                <button class="delete-btn" onclick="deleteMember(this)">삭제</button>
                            </div>
                        </td>
                    </tr>
                    <tr data-status="normal">
                        <td>강민지</td>
                        <td>30일 이용권 + 30일 락커 이용권 + PT 10회 이용권</td>
                        <td>2024.05.15</td>
                        <td>2025.05.15</td>
                        <td>A-34</td>
                        <td><span class="status-badge status-normal">정상</span></td>
                        <td>
                            <div class="action-buttons">
                                <button class="edit-btn" onclick="editMember(this)">수정</button>
                                <button class="delete-btn" onclick="deleteMember(this)">삭제</button>
                            </div>
                        </td>
                    </tr>
                    <tr data-status="expiring">
                        <td>윤태민</td>
                        <td>30일 이용권 + 30일 락커 이용권 + PT 10회 이용권</td>
                        <td>2024.07.20</td>
                        <td>2024.10.20</td>
                        <td>-</td>
                        <td><span class="status-badge status-expiring">만료임박</span></td>
                        <td>
                            <div class="action-buttons">
                                <button class="edit-btn" onclick="editMember(this)">수정</button>
                                <button class="delete-btn" onclick="deleteMember(this)">삭제</button>
                            </div>
                        </td>
                    </tr>
                    <tr data-status="normal">
                        <td>한소희</td>
                        <td>30일 이용권 + 30일 락커 이용권 + PT 10회 이용권</td>
                        <td>2024.09.01</td>
                        <td>2024.12.01</td>
                        <td>B-78</td>
                        <td><span class="status-badge status-normal">정상</span></td>
                        <td>
                            <div class="action-buttons">
                                <button class="edit-btn" onclick="editMember(this)">수정</button>
                                <button class="delete-btn" onclick="deleteMember(this)">삭제</button>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal: 신규 회원 등록 -->
<div class="modal-overlay" id="addMemberModal">
    <div class="modal">
        <div class="modal-header">
            <div class="modal-title-section">
                <h2>신규 회원 등록</h2>
                <p>신규 회원을 등록할 수 있습니다.</p>
            </div>
            <button class="modal-close-btn" onclick="closeAddMemberModal()">×</button>
        </div>
        <div class="modal-body">
            <!-- 아이디 조회 -->
            <div class="modal-form-group">
                <label>아이디 조회 <span class="required">*</span></label>
                <div class="modal-input-group">
                    <input type="text" class="modal-input" id="memberIdInput" placeholder="아이디를 입력하세요">
                    <button class="modal-btn" onclick="lookupMemberId()">아이디 조회</button>
                </div>
            </div>

            <!-- 회원 프로필 카드 -->
            <div class="member-profile-card" id="memberProfileCard" style="display: none;">
                <div class="profile-card-header">
                    <div class="profile-avatar">
                        <img id="profileAvatar" src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='60' height='60' viewBox='0 0 60 60'%3E%3Ccircle cx='30' cy='30' r='30' fill='%23ff6b00'/%3E%3Ctext x='30' y='40' text-anchor='middle' fill='white' font-size='24' font-weight='bold'%3E홍%3C/text%3E%3C/svg%3E" alt="프로필">
                    </div>
                    <div class="profile-info">
                        <div class="profile-name" id="profileName">홍길동</div>
                        <div class="profile-id" id="profileId">010015</div>
                    </div>
                </div>
                <div class="profile-card-body">
                    <div class="profile-detail-row">
                        <span class="profile-label">연락처</span>
                        <span class="profile-value" id="profilePhone">010-1234-5678</span>
                    </div>
                    <div class="profile-detail-row">
                        <span class="profile-label">이메일</span>
                        <span class="profile-value" id="profileEmail">hong@example.com</span>
                    </div>
                    <div class="profile-detail-row">
                        <span class="profile-label">주소</span>
                        <span class="profile-value" id="profileAddress">서울시 강남구 테헤란로 123</span>
                    </div>
                </div>
            </div>

            <!-- 이용권 등록 -->
            <div class="modal-form-group">
                <label>이용권 등록 <span class="required">*</span></label>
                <div class="modal-input-group">
                    <div class="modal-display-field" id="membershipDisplay"></div>
                    <button class="modal-btn modal-btn-secondary" onclick="registerMembership()">등록</button>
                </div>
            </div>

            <!-- 날짜 입력 -->
            <div class="modal-date-row">
                <div class="modal-form-group">
                    <label>시작일 <span class="required">*</span></label>
                    <input type="text" class="date-input-field" id="startDateInput" placeholder="날짜를 선택하세요" readonly onclick="openStartDateCalendar()">
                </div>
                <div class="modal-form-group">
                    <label>만료일 <span class="required">*</span></label>
                    <input type="text" class="modal-input" id="endDateInput" placeholder="자동 계산됩니다" readonly>
                </div>
            </div>

            <!-- 락커 번호 -->
            <div class="modal-form-group">
                <label>락커 번호</label>
                <div class="modal-input-group">
                    <input type="text" class="modal-input" id="lockerInput" placeholder="락커 조회 버튼을 클릭하세요" readonly>
                    <button class="modal-btn" onclick="lookupLocker()">락커 조회</button>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="modal-footer-btn modal-footer-btn-cancel" onclick="closeAddMemberModal()">취소</button>
            <button class="modal-footer-btn modal-footer-btn-submit" onclick="submitMemberRegistration()">등록</button>
        </div>
    </div>
</div>

<!-- Modal: 이용권 선택 -->
<div class="modal-overlay" id="membershipSelectModal">
    <div class="membership-select-modal">
        <div class="membership-select-header">
            <h2>이용권 선택</h2>
            <button class="membership-select-close-btn" onclick="closeMembershipSelectModal()">×</button>
        </div>
        <div class="membership-select-body">
            <!-- 회원권 -->
            <div class="membership-option">
                <div class="membership-checkbox-wrapper">
                    <input type="checkbox" class="membership-checkbox" id="gymMembershipCheck" onchange="toggleMembershipDropdown('gym')">
                    <label class="membership-label" for="gymMembershipCheck">회원권</label>
                </div>
                <div class="membership-dropdown-wrapper">
                    <select class="membership-dropdown" id="gymMembershipSelect" disabled>
                        <option value="">선택하세요</option>
                    </select>
                </div>
            </div>

            <!-- 락커 이용권 -->
            <div class="membership-option">
                <div class="membership-checkbox-wrapper">
                    <input type="checkbox" class="membership-checkbox" id="lockerMembershipCheck" onchange="toggleMembershipDropdown('locker')">
                    <label class="membership-label" for="lockerMembershipCheck">락커 이용권</label>
                </div>
                <div class="membership-dropdown-wrapper">
                    <select class="membership-dropdown" id="lockerMembershipSelect" disabled>
                        <option value="">선택하세요</option>
                    </select>
                </div>
            </div>

            <!-- PT 이용권 -->
            <div class="membership-option">
                <div class="membership-checkbox-wrapper">
                    <input type="checkbox" class="membership-checkbox" id="ptMembershipCheck" onchange="toggleMembershipDropdown('pt')">
                    <label class="membership-label" for="ptMembershipCheck">PT 이용권</label>
                </div>
                <div class="membership-dropdown-wrapper">
                    <select class="membership-dropdown" id="ptMembershipSelect" disabled>
                        <option value="">선택하세요</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="membership-select-footer">
            <button class="membership-select-btn membership-select-btn-cancel" onclick="closeMembershipSelectModal()">취소</button>
            <button class="membership-select-btn membership-select-btn-confirm" onclick="confirmMembershipSelection()">확인</button>
        </div>
    </div>
</div>

<!-- Modal: 등록 확정 -->
<div class="modal-overlay" id="confirmModal">
    <div class="confirm-modal">
        <div class="confirm-modal-header">
            <h2>회원 등록 확정</h2>
            <p>아래 회원 정보로 등록하시겠습니까?</p>
        </div>
        <div class="confirm-modal-body">
            <div class="confirm-profile-card">
                <div class="confirm-profile-header">
                    <div class="confirm-profile-avatar">
                        <img id="confirmAvatar" src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='60' height='60' viewBox='0 0 60 60'%3E%3Ccircle cx='30' cy='30' r='30' fill='%23ff6b00'/%3E%3Ctext x='30' y='40' text-anchor='middle' fill='white' font-size='24' font-weight='bold'%3E홍%3C/text%3E%3C/svg%3E" alt="프로필">
                    </div>
                    <div class="confirm-profile-info">
                        <div class="confirm-profile-name" id="confirmName">홍길동</div>
                        <div class="confirm-profile-id" id="confirmId">010015</div>
                    </div>
                </div>
                <div class="confirm-profile-details">
                    <div class="confirm-detail-row">
                        <span class="confirm-detail-label">연락처</span>
                        <span class="confirm-detail-value" id="confirmPhone">010-1234-5678</span>
                    </div>
                    <div class="confirm-detail-row">
                        <span class="confirm-detail-label">이메일</span>
                        <span class="confirm-detail-value" id="confirmEmail">hong@example.com</span>
                    </div>
                    <div class="confirm-detail-row">
                        <span class="confirm-detail-label">주소</span>
                        <span class="confirm-detail-value" id="confirmAddress">서울시 강남구 테헤란로 123</span>
                    </div>
                </div>
            </div>
            <div class="confirm-message">
                등록 후에는 회원 정보를 수정할 수 있습니다.
            </div>
        </div>
        <div class="confirm-modal-footer">
            <button class="confirm-modal-btn confirm-modal-btn-cancel" onclick="closeConfirmModal()">취소</button>
            <button class="confirm-modal-btn confirm-modal-btn-confirm" onclick="confirmRegistration()">등록 확정</button>
        </div>
    </div>
</div>

<!-- Modal: 락커 조회 -->
<div class="modal-overlay" id="lockerSelectModal">
    <div class="locker-select-modal">
        <div class="locker-select-header">
            <h2>락커번호</h2>
            <button class="locker-select-close-btn" onclick="closeLockerSelectModal()">×</button>
        </div>
        <div class="locker-select-body">
            <div class="locker-list" id="lockerList">
                <!-- 동적으로 락커 목록이 추가됩니다 -->
            </div>
        </div>
    </div>
</div>

<!-- 달력 팝업 -->
<div class="calendar-overlay" id="startDateCalendarOverlay" onclick="closeCalendarOnOverlay(event, 'startDateCalendarOverlay')">
    <div class="calendar-popup" onclick="event.stopPropagation()">
        <div class="calendar-header">
            <button type="button" class="calendar-nav-btn" onclick="prevMonthStartDate()">◀</button>
            <div class="calendar-month" id="startDateCalendarMonth"></div>
            <button type="button" class="calendar-nav-btn" onclick="nextMonthStartDate()">▶</button>
        </div>

        <div class="calendar-weekdays">
            <div class="calendar-weekday">일</div>
            <div class="calendar-weekday">월</div>
            <div class="calendar-weekday">화</div>
            <div class="calendar-weekday">수</div>
            <div class="calendar-weekday">목</div>
            <div class="calendar-weekday">금</div>
            <div class="calendar-weekday">토</div>
        </div>

        <div class="calendar-days" id="startDateCalendarDays"></div>

        <button type="button" class="calendar-close-btn" onclick="closeStartDateCalendar()">확인</button>
    </div>
</div>

<!-- Modal: 회원 정보 수정 -->
<div class="modal-overlay" id="editMemberModal">
    <div class="modal">
        <div class="modal-header">
            <div class="modal-title-section">
                <h2>회원 정보 수정</h2>
                <p>회원 정보를 수정할 수 있습니다.</p>
            </div>
            <button class="modal-close-btn" onclick="closeEditMemberModal()">×</button>
        </div>
        <div class="modal-body">
            <!-- 회원 프로필 카드 -->
            <div class="member-profile-card">
                <div class="profile-card-header">
                    <div class="profile-avatar">
                        <img id="editProfileAvatar" src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='60' height='60' viewBox='0 0 60 60'%3E%3Ccircle cx='30' cy='30' r='30' fill='%23ff6b00'/%3E%3Ctext x='30' y='40' text-anchor='middle' fill='white' font-size='24' font-weight='bold'%3E김%3C/text%3E%3C/svg%3E" alt="프로필">
                    </div>
                    <div class="profile-info">
                        <div class="profile-name" id="editProfileName">김회원</div>
                        <div class="profile-id" id="editProfileId">010015</div>
                    </div>
                </div>
                <div class="profile-card-body">
                    <div class="profile-detail-row">
                        <span class="profile-label">연락처</span>
                        <span class="profile-value" id="editProfilePhone">010-1234-5678</span>
                    </div>
                    <div class="profile-detail-row">
                        <span class="profile-label">이메일</span>
                        <span class="profile-value" id="editProfileEmail">hong@example.com</span>
                    </div>
                    <div class="profile-detail-row">
                        <span class="profile-label">주소</span>
                        <span class="profile-value" id="editProfileAddress">서울시 강남구 테헤란로 123</span>
                    </div>
                </div>
            </div>

            <!-- 이용권 정보 -->
            <div class="modal-form-group">
                <label>이용권 정보 <span class="required">*</span></label>
                <div class="modal-input-group">
                    <div class="modal-display-field" id="editMembershipDisplay">30일 이용권</div>
                    <button class="modal-btn modal-btn-secondary" onclick="editMembership()">수정</button>
                </div>
            </div>

            <!-- 날짜 입력 -->
            <div class="modal-date-row">
                <div class="modal-form-group">
                    <label>시작일 <span class="required">*</span></label>
                    <input type="text" class="date-input-field" id="editStartDateInput" placeholder="날짜를 선택하세요" readonly onclick="openEditStartDateCalendar()">
                </div>
                <div class="modal-form-group">
                    <label>만료일 <span class="required">*</span></label>
                    <input type="text" class="modal-input" id="editEndDateInput" placeholder="자동 계산됩니다" readonly>
                </div>
            </div>

            <!-- 락커 번호 -->
            <div class="modal-form-group">
                <label>락커 번호</label>
                <div class="modal-input-group">
                    <input type="text" class="modal-input" id="editLockerInput" placeholder="락커 조회 버튼을 클릭하세요" readonly>
                    <button class="modal-btn" onclick="lookupEditLocker()">락커 조회</button>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="modal-footer-btn modal-footer-btn-cancel" onclick="closeEditMemberModal()">취소</button>
            <button class="modal-footer-btn modal-footer-btn-submit" onclick="submitEditMember()">수정 완료</button>
        </div>
    </div>
</div>

<!-- 달력 팝업 (회원 수정용) -->
<div class="calendar-overlay" id="editStartDateCalendarOverlay" onclick="closeCalendarOnOverlay(event, 'editStartDateCalendarOverlay')">
    <div class="calendar-popup" onclick="event.stopPropagation()">
        <div class="calendar-header">
            <button type="button" class="calendar-nav-btn" onclick="prevMonthEditStartDate()">◀</button>
            <div class="calendar-month" id="editStartDateCalendarMonth"></div>
            <button type="button" class="calendar-nav-btn" onclick="nextMonthEditStartDate()">▶</button>
        </div>

        <div class="calendar-weekdays">
            <div class="calendar-weekday">일</div>
            <div class="calendar-weekday">월</div>
            <div class="calendar-weekday">화</div>
            <div class="calendar-weekday">수</div>
            <div class="calendar-weekday">목</div>
            <div class="calendar-weekday">금</div>
            <div class="calendar-weekday">토</div>
        </div>

        <div class="calendar-days" id="editStartDateCalendarDays"></div>

        <button type="button" class="calendar-close-btn" onclick="closeEditStartDateCalendar()">확인</button>
    </div>
</div>


<script>
    // 회원 필터링 함수
    let currentEditingMember = null;

    function filterMembers(status) {
        const rows = document.querySelectorAll('#memberTable tbody tr');

        rows.forEach(row => {
            if (status === 'all') {
                row.style.display = '';
            } else {
                if (row.dataset.status === status) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        });

        // 표시된 회원 수 업데이트
        const visibleRows = document.querySelectorAll('#memberTable tbody tr:not([style*="display: none"])');
        document.querySelector('.header-info p').textContent = '전체 ' + visibleRows.length + '명';
    }

    // 신규 회원 등록 함수
    function addMember() {
        document.getElementById('addMemberModal').classList.add('active');
    }

    // 모달 닫기 함수
    function closeAddMemberModal() {
        document.getElementById('addMemberModal').classList.remove('active');
        // 폼 초기화
        document.getElementById('memberIdInput').value = '';
        document.getElementById('membershipDisplay').textContent = '';
        document.getElementById('startDateInput').value = '';
        const endDateInput = document.getElementById('endDateInput');
        endDateInput.value = '';
        document.getElementById('lockerInput').value = '';
        // 프로필 카드 숨기기
        document.getElementById('memberProfileCard').style.display = 'none';
        // 달력 변수 초기화
        startDateSelected = null;
        startDateTempSelected = null;
        startDateCurrentMonth = new Date();
    }

    // 아이디 조회 함수
    function lookupMemberId() {
        const memberId = document.getElementById('memberIdInput').value.trim();
        if (!memberId) {
            alert('아이디를 입력해주세요.');
            return;
        }

        // 서버에서 회원 조회
        fetch('/member/lookup.ajax?memberId=' + encodeURIComponent(memberId))
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const member = data.member;
                    
                    // 프로필 카드에 데이터 설정
                    document.getElementById('profileName').textContent = member.memberName || '';
                    document.getElementById('profileId').textContent = member.memberId || '';
                    document.getElementById('profilePhone').textContent = member.memberPhone || '';
                    document.getElementById('profileEmail').textContent = member.memberEmail || '없음';
                    document.getElementById('profileAddress').textContent = member.memberAddress || '없음';

                    // 프로필 아바타 업데이트 (이름의 첫 글자로)
                    const firstChar = member.memberName ? member.memberName.charAt(0) : '?';
                    const avatarSvg = 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'60\' height=\'60\' viewBox=\'0 0 60 60\'%3E%3Ccircle cx=\'30\' cy=\'30\' r=\'30\' fill=\'%23ff6b00\'/%3E%3Ctext x=\'30\' y=\'40\' text-anchor=\'middle\' fill=\'white\' font-size=\'24\' font-weight=\'bold\'%3E' + encodeURIComponent(firstChar) + '%3C/text%3E%3C/svg%3E';
                    document.getElementById('profileAvatar').src = avatarSvg;

                    // 프로필 카드 표시
                    document.getElementById('memberProfileCard').style.display = 'block';
                    
                    // 회원 번호를 숨겨진 필드에 저장 (나중에 등록 시 사용)
                    document.getElementById('memberProfileCard').setAttribute('data-member-no', member.memberNo);
                } else {
                    alert(data.message || '회원 조회에 실패했습니다.');
                    // 프로필 카드 숨기기
                    document.getElementById('memberProfileCard').style.display = 'none';
                }
            })
            .catch(error => {
                console.error('회원 조회 오류:', error);
                alert('회원 조회 중 오류가 발생했습니다.');
                // 프로필 카드 숨기기
                document.getElementById('memberProfileCard').style.display = 'none';
            });
    }

    // 이용권 등록 함수
    function registerMembership() {
        // AJAX로 상품 목록 가져오기
        fetch('/member/products.ajax')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 회원권 select 옵션 생성
                    populateMembershipSelect('gymMembershipSelect', data.membership, 'month');
                    // 락커 이용권 select 옵션 생성
                    populateMembershipSelect('lockerMembershipSelect', data.locker, 'month');
                    // PT 이용권 select 옵션 생성
                    populateMembershipSelect('ptMembershipSelect', data.pt, 'count');
                    
                    // 회원권을 디폴트로 체크
                    document.getElementById('gymMembershipCheck').checked = true;
                    document.getElementById('gymMembershipSelect').disabled = false;

                    // 이용권 선택 모달 열기
                    document.getElementById('membershipSelectModal').classList.add('active');
                } else {
                    alert(data.message || '상품 목록을 불러오는데 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('상품 목록 조회 오류:', error);
                alert('상품 목록을 불러오는 중 오류가 발생했습니다.');
            });
    }

    // 이용권 select 옵션 생성 함수
    function populateMembershipSelect(selectId, products, type) {
        const select = document.getElementById(selectId);
        // 기존 옵션 제거 (첫 번째 "선택하세요" 옵션 제외)
        while (select.options.length > 1) {
            select.remove(1);
        }
        
        if (!products || products.length === 0) {
            return;
        }
        
        products.forEach(product => {
            const option = document.createElement('option');
            let displayText = '';
            
            if (type === 'month') {
                // 회원권/락커: 일 단위를 개월로 변환
                const months = Math.floor(product.durationMonths / 30);
                if (months === 12) {
                    displayText = '12개월';
                } else {
                    displayText = months + '개월';
                }
            } else if (type === 'count') {
                // PT: 횟수 그대로 표시
                displayText = product.durationMonths + '회';
            }
            
            option.value = displayText;
            option.textContent = displayText;
            // productNo를 data 속성에 저장 (나중에 필요할 수 있음)
            option.setAttribute('data-product-no', product.productNo);
            select.appendChild(option);
        });
    }

    // 이용권 선택 모달 닫기
    function closeMembershipSelectModal() {
        document.getElementById('membershipSelectModal').classList.remove('active');

        // 모달 폼 초기화
        document.getElementById('gymMembershipCheck').checked = false;
        document.getElementById('lockerMembershipCheck').checked = false;
        document.getElementById('ptMembershipCheck').checked = false;

        document.getElementById('gymMembershipSelect').value = '';
        document.getElementById('gymMembershipSelect').disabled = true;
        document.getElementById('lockerMembershipSelect').value = '';
        document.getElementById('lockerMembershipSelect').disabled = true;
        document.getElementById('ptMembershipSelect').value = '';
        document.getElementById('ptMembershipSelect').disabled = true;
    }

    // 이용권 드롭다운 토글
    function toggleMembershipDropdown(type) {
        const checkbox = document.getElementById(type + 'MembershipCheck');
        const select = document.getElementById(type + 'MembershipSelect');

        if (checkbox.checked) {
            select.disabled = false;
        } else {
            select.disabled = true;
            select.value = '';
        }
    }

    // 이용권 선택 확인
    function confirmMembershipSelection() {
        const gymCheck = document.getElementById('gymMembershipCheck').checked;
        const lockerCheck = document.getElementById('lockerMembershipCheck').checked;
        const ptCheck = document.getElementById('ptMembershipCheck').checked;

        const gymValue = document.getElementById('gymMembershipSelect').value;
        const lockerValue = document.getElementById('lockerMembershipSelect').value;
        const ptValue = document.getElementById('ptMembershipSelect').value;

        // 선택된 항목이 있는지 확인
        if (!gymCheck && !lockerCheck && !ptCheck) {
            alert('이용권을 최소 1개 이상 선택해주세요.');
            return;
        }

        // 체크된 항목의 값이 선택되었는지 확인
        if (gymCheck && !gymValue) {
            alert('회원권 기간을 선택해주세요.');
            return;
        }
        if (lockerCheck && !lockerValue) {
            alert('락커 이용권 기간을 선택해주세요.');
            return;
        }
        if (ptCheck && !ptValue) {
            alert('PT 이용권 횟수를 선택해주세요.');
            return;
        }

        // ✅ 선택된 이용권 텍스트 생성
        const selectedMemberships = [];
        if (gymCheck && gymValue) {
            selectedMemberships.push(gymValue + ' 회원권');
        }
        if (lockerCheck && lockerValue) {
            selectedMemberships.push(lockerValue + ' 락커 이용권');
        }
        if (ptCheck && ptValue) {
            selectedMemberships.push('PT ' + ptValue);
        }

        const membershipText = selectedMemberships.join(' + ');  // ✅ 이 줄 추가!

        // 이용권 표시 필드에 설정
        if (window.isEditingMembership) {
            document.getElementById('editMembershipDisplay').textContent = membershipText;
            window.isEditingMembership = false;
        } else {
            document.getElementById('membershipDisplay').textContent = membershipText;
        }

        closeMembershipSelectModal();
        alert('이용권이 선택되었습니다.');

        // 시작일이 이미 입력되어 있다면 종료일 자동 계산
        if (document.getElementById('startDateInput').value) {
            calculateEndDate();
        }
    }

    // 종료일 자동 계산 함수
    function calculateEndDate() {
        const startDateInput = document.getElementById('startDateInput');
        const endDateInput = document.getElementById('endDateInput');
        const membershipDisplay = document.getElementById('membershipDisplay').textContent;

        // 시작일이 선택되지 않았으면 리턴
        if (!startDateInput.value || !startDateSelected) {
            return;
        }

        // 이용권이 선택되지 않았으면 리턴
        if (!membershipDisplay) {
            alert('먼저 이용권을 선택해주세요.');
            startDateInput.value = '';
            startDateSelected = null;
            startDateTempSelected = null;
            return;
        }

        // 이용권에서 기간 추출 (회원권과 락커 이용권 중 가장 긴 기간)
        let maxDays = 0;

        // 회원권 기간 확인
        if (membershipDisplay.includes('회원권')) {
            const gymMatch = membershipDisplay.match(/(\d+)개월\s*회원권/);
            if (gymMatch) {
                const months = parseInt(gymMatch[1]);
                // 1개월 = 30일, 12개월 = 365일로 계산
                const days = months === 12 ? 365 : months * 30;
                maxDays = Math.max(maxDays, days);
            }
        }

        // 락커 이용권 기간 확인
        if (membershipDisplay.includes('락커 이용권')) {
            const lockerMatch = membershipDisplay.match(/(\d+)개월\s*락커 이용권/);
            if (lockerMatch) {
                const months = parseInt(lockerMatch[1]);
                // 1개월 = 30일, 12개월 = 365일로 계산
                const days = months === 12 ? 365 : months * 30;
                maxDays = Math.max(maxDays, days);
            }
        }

        // 기간이 설정되지 않았으면 리턴
        if (maxDays === 0) {
            return;
        }

        // 종료일 계산
        const endDate = new Date(startDateSelected.getTime());
        endDate.setDate(endDate.getDate() + maxDays);

        // 종료일을 YYYY-MM-DD 형식으로 변환
        const endYear = endDate.getFullYear();
        const endMonth = String(endDate.getMonth() + 1).padStart(2, '0');
        const endDay = String(endDate.getDate()).padStart(2, '0');
        const endDateString = endYear + '-' + endMonth + '-' + endDay;

        // 종료일 필드에 설정
        endDateInput.value = endDateString;
    }

    // 이용권 선택 모달 외부 클릭 시 닫기
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('membershipSelectModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeMembershipSelectModal();
            }
        });
    });

    // 락커 조회 함수
    function lookupLocker() {
        // 락커 선택 모달 열기
        openLockerSelectModal();
    }

    // 락커 선택 모달 열기
    function openLockerSelectModal() {
        // 빈 락커 목록 (실제로는 서버에서 가져와야 함)
        const availableLockers = [
            'A-1', 'A-5', 'A-12', 'A-23', 'A-45', 'A-56',
            'B-68', 'B-72', 'B-89', 'C-15', 'C-34', 'C-67'
        ];

        // 락커 목록 생성
        const lockerList = document.getElementById('lockerList');
        lockerList.innerHTML = '';

        availableLockers.forEach(locker => {
            const lockerItem = document.createElement('div');
            lockerItem.className = 'locker-item';

            const lockerNumber = document.createElement('span');
            lockerNumber.className = 'locker-number';
            lockerNumber.textContent = locker;

            const assignBtn = document.createElement('button');
            assignBtn.className = 'locker-assign-btn';
            assignBtn.textContent = '배정';
            assignBtn.onclick = function() {
                assignLocker(locker);
            };

            lockerItem.appendChild(lockerNumber);
            lockerItem.appendChild(assignBtn);
            lockerList.appendChild(lockerItem);
        });

        // 모달 열기
        document.getElementById('lockerSelectModal').classList.add('active');
    }

    // 락커 배정 함수
    function assignLocker(lockerNumber) {
        document.getElementById('lockerInput').value = lockerNumber;
        closeLockerSelectModal();
    }

    // 락커 선택 모달 닫기
    function closeLockerSelectModal() {
        document.getElementById('lockerSelectModal').classList.remove('active');
    }

    // 회원 등록 제출 함수
    function submitMemberRegistration() {
        const memberId = document.getElementById('memberIdInput').value;
        const membership = document.getElementById('membershipDisplay').textContent;
        const startDate = document.getElementById('startDateInput').value;
        const endDate = document.getElementById('endDateInput').value;
        const locker = document.getElementById('lockerInput').value;

        // 필수 항목 검증
        if (!memberId) {
            alert('아이디를 입력해주세요.');
            return;
        }

        // 프로필 카드가 표시되지 않았으면
        if (document.getElementById('memberProfileCard').style.display === 'none') {
            alert('아이디 조회를 먼저 진행해주세요.');
            return;
        }

        if (!membership) {
            alert('이용권을 등록해주세요.');
            return;
        }

        if (!startDate) {
            alert('시작일을 입력해주세요.');
            return;
        }

        if (!endDate) {
            alert('만료일을 입력해주세요.');
            return;
        }

        // 등록 확정 모달에 데이터 설정
        const name = document.getElementById('profileName').textContent;
        const id = document.getElementById('profileId').textContent;
        const phone = document.getElementById('profilePhone').textContent;
        const email = document.getElementById('profileEmail').textContent;
        const address = document.getElementById('profileAddress').textContent;

        document.getElementById('confirmName').textContent = name;
        document.getElementById('confirmId').textContent = id;
        document.getElementById('confirmPhone').textContent = phone;
        document.getElementById('confirmEmail').textContent = email;
        document.getElementById('confirmAddress').textContent = address;

        // 아바타도 복사
        const avatarSrc = document.getElementById('profileAvatar').src;
        document.getElementById('confirmAvatar').src = avatarSrc;

        // 등록 확정 모달 표시
        document.getElementById('confirmModal').classList.add('active');
    }

    // 등록 확정 모달 닫기
    function closeConfirmModal() {
        document.getElementById('confirmModal').classList.remove('active');
    }

    // 최종 등록 확정
    function confirmRegistration() {
        const memberId = document.getElementById('memberIdInput').value;
        const membership = document.getElementById('membershipDisplay').textContent;
        const startDate = document.getElementById('startDateInput').value;
        const endDate = document.getElementById('endDateInput').value;
        const locker = document.getElementById('lockerInput').value;
        const name = document.getElementById('confirmName').textContent;

        // 실제로는 서버로 데이터 전송
        console.log('회원 등록 데이터:', {
            memberId,
            name,
            membership,
            startDate,
            endDate,
            locker
        });

        alert('회원이 등록되었습니다!');
        closeConfirmModal();
        closeAddMemberModal();

        // 페이지 새로고침 또는 테이블 업데이트
        // location.reload();
    }

    // 모달 외부 클릭 시 닫기 (DOMContentLoaded 안에서 실행)
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('addMemberModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeAddMemberModal();
            }
        });

        document.getElementById('confirmModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeConfirmModal();
            }
        });

        document.getElementById('lockerSelectModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeLockerSelectModal();
            }
        });

        document.getElementById('editMemberModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeEditMemberModal();
            }
        });
    });

    // 회원 정보 수정 함수
    function editMember(button) {
        const row = button.closest('tr');
        const name = row.querySelector('td:nth-child(1)').textContent;
        const membership = row.querySelector('td:nth-child(2)').textContent;
        const startDate = row.querySelector('td:nth-child(3)').textContent;
        const endDate = row.querySelector('td:nth-child(4)').textContent;
        const locker = row.querySelector('td:nth-child(5)').textContent;

        currentEditingMember = {
            row: row,
            name: name,
            membership: membership,
            startDate: startDate,
            endDate: endDate,
            locker: locker
        };

        document.getElementById('editProfileName').textContent = name;
        document.getElementById('editProfileId').textContent = '010015';
        document.getElementById('editProfilePhone').textContent = '010-1234-5678';
        document.getElementById('editProfileEmail').textContent = 'member@example.com';
        document.getElementById('editProfileAddress').textContent = '서울시 강남구';

        const firstChar = name.charAt(0);
        const avatarSvg = 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'60\' height=\'60\' viewBox=\'0 0 60 60\'%3E%3Ccircle cx=\'30\' cy=\'30\' r=\'30\' fill=\'%23ff6b00\'/%3E%3Ctext x=\'30\' y=\'40\' text-anchor=\'middle\' fill=\'white\' font-size=\'24\' font-weight=\'bold\'%3E' + encodeURIComponent(firstChar) + '%3C/text%3E%3C/svg%3E';
        document.getElementById('editProfileAvatar').src = avatarSvg;

        document.getElementById('editMembershipDisplay').textContent = membership;
        document.getElementById('editStartDateInput').value = startDate;
        document.getElementById('editEndDateInput').value = endDate;
        document.getElementById('editLockerInput').value = locker === '-' ? '' : locker;

        document.getElementById('editMemberModal').classList.add('active');
    }


    // 회원 삭제 함수
    function deleteMember(button) {
        const row = button.closest('tr');
        const name = row.querySelector('td:first-child').textContent;

        if (confirm(name + ' 회원을 삭제하시겠습니까?')) {
            row.remove();

            // 전체 회원 수 업데이트
            const totalRows = document.querySelectorAll('#memberTable tbody tr').length;
            document.querySelector('.header-info p').textContent = '전체 ' + totalRows + '명';

            alert(name + ' 회원을 삭제했습니다.');
        }
    }

    // ========================================
    // 달력 관련 함수
    // ========================================

    let startDateCurrentMonth = new Date();
    let startDateTempSelected = null;
    let startDateSelected = null;

    // 달력 열기
    function openStartDateCalendar() {
        document.getElementById('startDateCalendarOverlay').classList.add('show');
        renderStartDateCalendar();
    }

    // 달력 닫기
    function closeStartDateCalendar() {
        document.getElementById('startDateCalendarOverlay').classList.remove('show');
        if (startDateTempSelected) {
            startDateSelected = startDateTempSelected;
            updateStartDateDisplay();
            calculateEndDate();
        }
    }

    // 오버레이 클릭 시 닫기
    function closeCalendarOnOverlay(event, overlayId) {
        if (event.target === event.currentTarget) {
            if (overlayId === 'startDateCalendarOverlay') {
                closeStartDateCalendar();
            } else if (overlayId === 'editStartDateCalendarOverlay') {
                closeEditStartDateCalendar();
            }
        }
    }

    // 이전 달
    function prevMonthStartDate() {
        startDateCurrentMonth.setMonth(startDateCurrentMonth.getMonth() - 1);
        renderStartDateCalendar();
    }

    // 다음 달
    function nextMonthStartDate() {
        startDateCurrentMonth.setMonth(startDateCurrentMonth.getMonth() + 1);
        renderStartDateCalendar();
    }

    // 달력 렌더링
    function renderStartDateCalendar() {
        const year = startDateCurrentMonth.getFullYear();
        const month = startDateCurrentMonth.getMonth();

        document.getElementById('startDateCalendarMonth').textContent =
            year + '년 ' + (month + 1) + '월';

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const today = new Date();

        const daysContainer = document.getElementById('startDateCalendarDays');
        daysContainer.innerHTML = '';

        // 빈 칸 채우기
        for (let i = 0; i < firstDay; i++) {
            const emptyDay = document.createElement('div');
            daysContainer.appendChild(emptyDay);
        }

        // 날짜 채우기
        for (let day = 1; day <= daysInMonth; day++) {
            const dayElement = document.createElement('div');
            dayElement.className = 'calendar-day';
            dayElement.textContent = day;

            const currentDate = new Date(year, month, day);

            // 과거 날짜는 비활성화
            if (currentDate < new Date(today.getFullYear(), today.getMonth(), today.getDate())) {
                dayElement.classList.add('disabled');
            } else {
                // 선택된 날짜 표시
                if (startDateTempSelected &&
                    startDateTempSelected.getDate() === day &&
                    startDateTempSelected.getMonth() === month &&
                    startDateTempSelected.getFullYear() === year) {
                    dayElement.classList.add('selected');
                }

                dayElement.onclick = function() {
                    document.querySelectorAll('#startDateCalendarDays .calendar-day.selected').forEach(d => {
                        d.classList.remove('selected');
                    });
                    this.classList.add('selected');
                    startDateTempSelected = new Date(year, month, day);
                };
            }

            daysContainer.appendChild(dayElement);
        }
    }

    // 시작일 표시 업데이트
    function updateStartDateDisplay() {
        if (startDateSelected) {
            const year = startDateSelected.getFullYear();
            const month = String(startDateSelected.getMonth() + 1).padStart(2, '0');
            const day = String(startDateSelected.getDate()).padStart(2, '0');

            const dateString = year + '-' + month + '-' + day;
            document.getElementById('startDateInput').value = dateString;
        }
    }


    // 회원 수정 모달 닫기
    function closeEditMemberModal() {
        document.getElementById('editMemberModal').classList.remove('active');
        currentEditingMember = null;
        editStartDateSelected = null;
        editStartDateTempSelected = null;
        editStartDateCurrentMonth = new Date();
    }

    // 이용권 수정
    function editMembership() {
        window.isEditingMembership = true;
        
        // AJAX로 상품 목록 가져오기
        fetch('/member/products.ajax')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 회원권 select 옵션 생성
                    populateMembershipSelect('gymMembershipSelect', data.membership, 'month');
                    // 락커 이용권 select 옵션 생성
                    populateMembershipSelect('lockerMembershipSelect', data.locker, 'month');
                    // PT 이용권 select 옵션 생성
                    populateMembershipSelect('ptMembershipSelect', data.pt, 'count');
                    
                    // 이용권 선택 모달 열기
                    document.getElementById('membershipSelectModal').classList.add('active');
                } else {
                    alert(data.message || '상품 목록을 불러오는데 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('상품 목록 조회 오류:', error);
                alert('상품 목록을 불러오는 중 오류가 발생했습니다.');
            });
    }

    // 락커 조회 (수정용)
    // 락커 조회 (수정용)
    function lookupEditLocker() {
        // 빈 락커 목록 (실제로는 서버에서 가져와야 함)
        const availableLockers = [
            'A-1', 'A-5', 'A-12', 'A-23', 'A-45', 'A-56',
            'B-68', 'B-72', 'B-89', 'C-15', 'C-34', 'C-67'
        ];

        // 락커 목록 생성
        const lockerList = document.getElementById('lockerList');
        lockerList.innerHTML = '';

        availableLockers.forEach(locker => {
            const lockerItem = document.createElement('div');
            lockerItem.className = 'locker-item';

            const lockerNumber = document.createElement('span');
            lockerNumber.className = 'locker-number';
            lockerNumber.textContent = locker;

            const assignBtn = document.createElement('button');
            assignBtn.className = 'locker-assign-btn';
            assignBtn.textContent = '배정';
            assignBtn.onclick = function() {
                assignEditLocker(locker);
            };

            lockerItem.appendChild(lockerNumber);
            lockerItem.appendChild(assignBtn);
            lockerList.appendChild(lockerItem);
        });

        // 모달 열기
        document.getElementById('lockerSelectModal').classList.add('active');
    }

    // 락커 배정 함수 (수정용)
    function assignEditLocker(lockerNumber) {
        document.getElementById('editLockerInput').value = lockerNumber;
        closeLockerSelectModal();
    }


    // 회원 수정 제출
    function submitEditMember() {
        const membership = document.getElementById('editMembershipDisplay').textContent;
        const startDate = document.getElementById('editStartDateInput').value;
        const endDate = document.getElementById('editEndDateInput').value;
        const locker = document.getElementById('editLockerInput').value;

        if (!membership) {
            alert('이용권 정보를 입력해주세요.');
            return;
        }
        if (!startDate) {
            alert('시작일을 입력해주세요.');
            return;
        }
        if (!endDate) {
            alert('만료일을 입력해주세요.');
            return;
        }

        if (currentEditingMember && currentEditingMember.row) {
            const row = currentEditingMember.row;
            row.querySelector('td:nth-child(2)').textContent = membership;
            row.querySelector('td:nth-child(3)').textContent = startDate;
            row.querySelector('td:nth-child(4)').textContent = endDate;
            row.querySelector('td:nth-child(5)').textContent = locker || '-';
        }

        alert('회원 정보가 수정되었습니다!');
        closeEditMemberModal();
    }

    // 수정용 달력 관련
    let editStartDateCurrentMonth = new Date();
    let editStartDateTempSelected = null;
    let editStartDateSelected = null;

    function openEditStartDateCalendar() {
        document.getElementById('editStartDateCalendarOverlay').classList.add('show');
        renderEditStartDateCalendar();
    }

    function closeEditStartDateCalendar() {
        document.getElementById('editStartDateCalendarOverlay').classList.remove('show');
        if (editStartDateTempSelected) {
            editStartDateSelected = editStartDateTempSelected;
            updateEditStartDateDisplay();
            calculateEditEndDate();
        }
    }

    function prevMonthEditStartDate() {
        editStartDateCurrentMonth.setMonth(editStartDateCurrentMonth.getMonth() - 1);
        renderEditStartDateCalendar();
    }

    function nextMonthEditStartDate() {
        editStartDateCurrentMonth.setMonth(editStartDateCurrentMonth.getMonth() + 1);
        renderEditStartDateCalendar();
    }

    function renderEditStartDateCalendar() {
        const year = editStartDateCurrentMonth.getFullYear();
        const month = editStartDateCurrentMonth.getMonth();

        document.getElementById('editStartDateCalendarMonth').textContent =
            year + '년 ' + (month + 1) + '월';

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const today = new Date();

        const calendarDays = document.getElementById('editStartDateCalendarDays');
        calendarDays.innerHTML = '';

        // 빈 칸 채우기
        for (let i = 0; i < firstDay; i++) {
            const emptyDiv = document.createElement('div');
            emptyDiv.className = 'calendar-day empty';
            calendarDays.appendChild(emptyDiv);
        }

        // 날짜 채우기
        for (let day = 1; day <= daysInMonth; day++) {
            const dayDiv = document.createElement('div');
            dayDiv.className = 'calendar-day';
            dayDiv.textContent = day;

            const currentDate = new Date(year, month, day);

            // 과거 날짜는 비활성화
            if (currentDate < new Date(today.getFullYear(), today.getMonth(), today.getDate())) {
                dayDiv.classList.add('disabled');
            } else {
                // 선택된 날짜 표시
                if (editStartDateTempSelected &&
                    editStartDateTempSelected.getDate() === day &&
                    editStartDateTempSelected.getMonth() === month &&
                    editStartDateTempSelected.getFullYear() === year) {
                    dayDiv.classList.add('selected');
                }

                dayDiv.onclick = function() {
                    document.querySelectorAll('#editStartDateCalendarDays .calendar-day.selected').forEach(d => {
                        d.classList.remove('selected');
                    });
                    this.classList.add('selected');
                    editStartDateTempSelected = new Date(year, month, day);
                };
            }

            calendarDays.appendChild(dayDiv);
        }
    }

    function updateEditStartDateDisplay() {
        if (editStartDateSelected) {
            const year = editStartDateSelected.getFullYear();
            const month = String(editStartDateSelected.getMonth() + 1).padStart(2, '0');
            const day = String(editStartDateSelected.getDate()).padStart(2, '0');
            document.getElementById('editStartDateInput').value = year + '-' + month + '-' + day;
        }
    }

    function calculateEditEndDate() {
        if (!editStartDateSelected) return;

        const editMembershipDisplay = document.getElementById('editMembershipDisplay').textContent;
        if (!editMembershipDisplay) return;

        // 이용권에서 기간 추출 (회원권과 락커 이용권 중 가장 긴 기간)
        let maxDays = 0;

        // 회원권 기간 확인
        if (editMembershipDisplay.includes('회원권')) {
            const gymMatch = editMembershipDisplay.match(/(\d+)개월\s*회원권/);
            if (gymMatch) {
                const months = parseInt(gymMatch[1]);
                const days = months === 12 ? 365 : months * 30;
                maxDays = Math.max(maxDays, days);
            }
        }

        // 락커 이용권 기간 확인
        if (editMembershipDisplay.includes('락커 이용권')) {
            const lockerMatch = editMembershipDisplay.match(/(\d+)개월\s*락커 이용권/);
            if (lockerMatch) {
                const months = parseInt(lockerMatch[1]);
                const days = months === 12 ? 365 : months * 30;
                maxDays = Math.max(maxDays, days);
            }
        }

        if (maxDays === 0) return;

        const endDate = new Date(editStartDateSelected.getTime());
        endDate.setDate(endDate.getDate() + maxDays);

        const year = endDate.getFullYear();
        const month = String(endDate.getMonth() + 1).padStart(2, '0');
        const day = String(endDate.getDate()).padStart(2, '0');
        document.getElementById('editEndDateInput').value = year + '-' + month + '-' + day;
    }



</script>
</body>
</html>

