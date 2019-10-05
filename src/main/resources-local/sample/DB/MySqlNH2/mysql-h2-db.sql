CREATE TABLE SAMPLE_MEMBER_MST
(
    MEMBER_ID      VARCHAR(100) PRIMARY KEY NOT NULL,
    MEMBER_PW      CHAR(128)                NOT NULL,
    MEMBER_NAME    VARCHAR(100)             NOT NULL,
    MEMBER_TYPE    VARCHAR(100)             NOT NULL,
    LOGIN_FAIL_CNT INT(1) DEFAULT 0         NOT NULL,
    CLOSE_TF       BOOLEAN                  NOT NULL,
    TOKEN          VARCHAR(102)             NULL,
    EXPIRED        DATETIME                 NOT NULL,
    CREATED_BY     VARCHAR(100)             NOT NULL,
    CREATED        DATETIME                 NOT NULL,
    UPDATED_BY     VARCHAR(100)             NOT NULL,
    UPDATED        DATETIME                 NOT NULL
);
INSERT
INTO SAMPLE_MEMBER_MST
(MEMBER_ID,
 MEMBER_PW,
 MEMBER_NAME,
 MEMBER_TYPE,
 LOGIN_FAIL_CNT,
 CLOSE_TF,
 EXPIRED,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('developer',
        '4dff4ea340f0a823f15d3f4f01ab62eae0e5da579ccb851f8db9dfe84c58b2b37b89903a740e1ee172da793a6e79d560e5f7f9bd058a12a280433ed6fa46510a',
        '개발자',
        '999',
        0,
        FALSE,
        NOW() + 365,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_MEMBER_MST
(MEMBER_ID,
 MEMBER_PW,
 MEMBER_NAME,
 MEMBER_TYPE,
 LOGIN_FAIL_CNT,
 CLOSE_TF,
 EXPIRED,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('1',
        '4dff4ea340f0a823f15d3f4f01ab62eae0e5da579ccb851f8db9dfe84c58b2b37b89903a740e1ee172da793a6e79d560e5f7f9bd058a12a280433ed6fa46510a',
        '1',
        '999',
        0,
        FALSE,
        NOW() + 365,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_MEMBER_MST
(MEMBER_ID,
 MEMBER_PW,
 MEMBER_NAME,
 MEMBER_TYPE,
 LOGIN_FAIL_CNT,
 CLOSE_TF,
 EXPIRED,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('bestheroz',
        '4dff4ea340f0a823f15d3f4f01ab62eae0e5da579ccb851f8db9dfe84c58b2b37b89903a740e1ee172da793a6e79d560e5f7f9bd058a12a280433ed6fa46510a',
        '개발자/김동준M',
        '999',
        0,
        FALSE,
        NOW() + 365,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_MEMBER_MST
(MEMBER_ID,
 MEMBER_PW,
 MEMBER_NAME,
 MEMBER_TYPE,
 LOGIN_FAIL_CNT,
 CLOSE_TF,
 EXPIRED,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('guest',
        '4dff4ea340f0a823f15d3f4f01ab62eae0e5da579ccb851f8db9dfe84c58b2b37b89903a740e1ee172da793a6e79d560e5f7f9bd058a12a280433ed6fa46510a',
        '게스트',
        '300',
        0,
        FALSE,
        NOW() + 365,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

COMMIT;
CREATE TABLE SAMPLE_MENU_MST
(
    MENU_ID       INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    MENU_NAME     VARCHAR(1000)       NOT NULL,
    MENU_TYPE     CHAR(1)             NOT NULL,
    PAR_MENU_ID   INT(10)             NOT NULL,
    USE_TF        BOOLEAN             NOT NULL,
    POWER         INT(10)             NOT NULL,
    DISPLAY_ORDER INT(10)             NOT NULL,
    URL           VARCHAR(4000),
    REMARK1       VARCHAR(4000),
    CREATED_BY    VARCHAR(100)        NOT NULL,
    CREATED       DATETIME            NOT NULL,
    UPDATED_BY    VARCHAR(100)        NOT NULL,
    UPDATED       DATETIME            NOT NULL
);

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 REMARK1,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('Root',
        'G',
        '0',
        TRUE,
        300,
        1,
        '/',
        'MYSPRING 최상위',
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT 'JS 가이드',
       'G',
       MENU_ID,
       TRUE,
       300,
       10,
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'Root';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT 'JSP 가이드',
       'G',
       MENU_ID,
       TRUE,
       300,
       20,
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'Root';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT 'Github',
       'G',
       MENU_ID,
       TRUE,
       300,
       70,
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'Root';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '관리자',
       'G',
       MENU_ID,
       TRUE,
       700,
       110,
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'Root';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '메뉴관리',
       'P',
       MENU_ID,
       TRUE,
       700,
       1,
       '/sample/admin/menu/adminMenu.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = '관리자';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '코드관리',
       'P',
       MENU_ID,
       TRUE,
       700,
       3,
       '/sample/admin/valuelabel/adminValueLabel.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = '관리자';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '우편번호검색API',
       'P',
       MENU_ID,
       TRUE,
       300,
       30,
       '/sample/guide/postcode/sampleGuidePostcode.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '회원관리',
       'P',
       MENU_ID,
       TRUE,
       700,
       5,
       '/sample/admin/member/adminMember.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = '관리자';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '모든 프로젝트 보기',
       'P',
       MENU_ID,
       TRUE,
       300,
       1,
       'http://10.125.251.12/explore/projects',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'Github';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '개발환경구축가이드',
       'P',
       MENU_ID,
       TRUE,
       300,
       10,
       NULL,
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'Github';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '표준 웹 프로젝트',
       'P',
       MENU_ID,
       TRUE,
       300,
       20,
       NULL,
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'Github';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '모달(modal) 띄우기',
       'P',
       MENU_ID,
       TRUE,
       300,
       10,
       '/sample/guide/modal/sampleGuideModal.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT 'ajax 요청하기',
       'P',
       MENU_ID,
       TRUE,
       300,
       1,
       '/sample/guide/ajax/sampleGuideAjax.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '팝업(popup)창 띄우기',
       'P',
       MENU_ID,
       TRUE,
       300,
       11,
       '/sample/guide/popup/sampleGuidePopup.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '달력 및 시간: datetimepicker',
       'P',
       MENU_ID,
       TRUE,
       300,
       40,
       '/sample/guide/datetimepicker/sampleGuideDatetimepicker.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT 'ajax - 파일다운로드',
       'P',
       MENU_ID,
       TRUE,
       300,
       6,
       '/sample/guide/ajax/sampleGuideAjax.view?#list4',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '날짜 처리',
       'P',
       MENU_ID,
       TRUE,
       300,
       20,
       '/sample/guide/format/sampleGuideFormat.view?#list1',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '필드 검증하기(필수값 등)',
       'P',
       MENU_ID,
       TRUE,
       300,
       15,
       '/sample/guide/validate/field/sampleGuideValidateField.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '값 검증하기',
       'P',
       MENU_ID,
       TRUE,
       300,
       16,
       '/sample/guide/validate/value/sampleGuideValidateValue.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '페이징 처리',
       'P',
       MENU_ID,
       TRUE,
       300,
       90,
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT 'ajax - 파일업로드',
       'P',
       MENU_ID,
       TRUE,
       300,
       5,
       '/sample/guide/ajax/sampleGuideAjax.view?#list2',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '텍스트 에디터',
       'P',
       MENU_ID,
       TRUE,
       300,
       60,
       '/sample/guide/texteditor/sampleGuideTexteditor.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT 'HTML템플릿 - 핸들바JS',
       'P',
       MENU_ID,
       TRUE,
       300,
       70,
       '/sample/guide/handlebarsjs/sampleGuideHandlebarsjs.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '숫자 포맷&#40;콤마찍기 등&#41;',
       'P',
       MENU_ID,
       TRUE,
       300,
       25,
       '/sample/guide/format/sampleGuideFormat.view?#list2',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JS 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT 'my:html',
       'P',
       MENU_ID,
       TRUE,
       300,
       10,
       '/sample/guide/html/sampleGuideHtml.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JSP 가이드';

INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '표준 API 프로젝트',
       'P',
       MENU_ID,
       TRUE,
       300,
       30,
       NULL,
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = 'JSP 가이드';


INSERT
INTO SAMPLE_MENU_MST
(MENU_NAME,
 MENU_TYPE,
 PAR_MENU_ID,
 USE_TF,
 POWER,
 DISPLAY_ORDER,
 URL,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
SELECT '파일관리',
       'P',
       MENU_ID,
       TRUE,
       700,
       40,
       '/sample/admin/file/adminFile.view',
       'bestheroz',
       NOW(),
       'bestheroz',
       NOW()
FROM SAMPLE_MENU_MST
WHERE MENU_NAME = '관리자';

COMMIT;

CREATE TABLE SAMPLE_CODE_MST
(
    GROUP_CODE      VARCHAR(100) PRIMARY KEY NOT NULL,
    GROUP_CODE_NAME VARCHAR(1000)            NOT NULL,
    REMARK1         VARCHAR(4000),
    CREATED_BY      VARCHAR(100)             NOT NULL,
    CREATED         DATETIME                 NOT NULL,
    UPDATED_BY      VARCHAR(100)             NOT NULL,
    UPDATED         DATETIME                 NOT NULL
);

INSERT
INTO SAMPLE_CODE_MST
(GROUP_CODE,
 GROUP_CODE_NAME,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('MENU_TYPE',
        '메뉴타입',
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_MST
(GROUP_CODE,
 GROUP_CODE_NAME,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('USE_TF',
        '사용여부',
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_MST
(GROUP_CODE,
 GROUP_CODE_NAME,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('MEMBER_TYPE',
        '회원구분',
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_MST
(GROUP_CODE,
 GROUP_CODE_NAME,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('USE_TF_REVERSE',
        '사용여부(아니오부터 출력)',
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

COMMIT;

CREATE TABLE SAMPLE_CODE_DET
(
    GROUP_CODE    VARCHAR(100)  NOT NULL,
    CODE          VARCHAR(100)  NOT NULL,
    CODE_NAME     VARCHAR(1000) NOT NULL,
    USE_TF        VARCHAR(1)    NOT NULL,
    DISPLAY_ORDER INT(10)       NOT NULL,
    REMARK1       VARCHAR(4000),
    CREATED_BY    VARCHAR(100)  NOT NULL,
    CREATED       DATETIME      NOT NULL,
    UPDATED_BY    VARCHAR(100)  NOT NULL,
    UPDATED       DATETIME      NOT NULL
);

CREATE INDEX IDX_SAMPLE_CODE_DET
    ON SAMPLE_CODE_DET
        (
         GROUP_CODE,
         DISPLAY_ORDER
            );

ALTER TABLE SAMPLE_CODE_DET
    ADD PRIMARY KEY (GROUP_CODE, CODE);

INSERT
INTO SAMPLE_CODE_DET
(GROUP_CODE,
 CODE,
 CODE_NAME,
 USE_TF,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('USE_TF',
        'TRUE',
        '예',
        TRUE,
        1,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_DET
(GROUP_CODE,
 CODE,
 CODE_NAME,
 USE_TF,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('USE_TF',
        'FALSE',
        '아니요',
        TRUE,
        2,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_DET
(GROUP_CODE,
 CODE,
 CODE_NAME,
 USE_TF,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('MENU_TYPE',
        'G',
        '그룹',
        TRUE,
        1,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_DET
(GROUP_CODE,
 CODE,
 CODE_NAME,
 USE_TF,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('MENU_TYPE',
        'P',
        '페이지',
        TRUE,
        2,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_DET
(GROUP_CODE,
 CODE,
 CODE_NAME,
 USE_TF,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('USE_TF_REVERSE',
        FALSE,
        '아니요',
        TRUE,
        1,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_DET
(GROUP_CODE,
 CODE,
 CODE_NAME,
 USE_TF,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('USE_TF_REVERSE',
        TRUE,
        '예',
        TRUE,
        2,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_DET
(GROUP_CODE,
 CODE,
 CODE_NAME,
 USE_TF,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('MEMBER_TYPE',
        '300',
        '손님',
        TRUE,
        3,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_DET
(GROUP_CODE,
 CODE,
 CODE_NAME,
 USE_TF,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('MEMBER_TYPE',
        '500',
        '일반유저',
        TRUE,
        5,
        'bestheroz',
        NOW(),
        'developer',
        NOW());

INSERT
INTO SAMPLE_CODE_DET
(GROUP_CODE,
 CODE,
 CODE_NAME,
 USE_TF,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('MEMBER_TYPE',
        '700',
        '관리자',
        TRUE,
        7,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_DET
(GROUP_CODE,
 CODE,
 CODE_NAME,
 USE_TF,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('MEMBER_TYPE',
        '800',
        'Master 관리자',
        TRUE,
        8,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

INSERT
INTO SAMPLE_CODE_DET
(GROUP_CODE,
 CODE,
 CODE_NAME,
 USE_TF,
 DISPLAY_ORDER,
 CREATED_BY,
 CREATED,
 UPDATED_BY,
 UPDATED)
VALUES ('MEMBER_TYPE',
        '999',
        '개발자',
        TRUE,
        10,
        'bestheroz',
        NOW(),
        'bestheroz',
        NOW());

COMMIT;

CREATE TABLE SAMPLE_FILE_MST
(
    FILE_SEQ      INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    FILE_NAME     VARCHAR(4000)       NOT NULL,
    FILE_NAME_EXT VARCHAR(100)        NOT NULL,
    MIME_TYPE     VARCHAR(100)        NOT NULL,
    FILE_DATA     BLOB                NOT NULL,
    CREATED_BY    VARCHAR(100)        NOT NULL,
    CREATED       DATETIME            NOT NULL,
    UPDATED_BY    VARCHAR(100)        NOT NULL,
    UPDATED       DATETIME            NOT NULL
);

CREATE INDEX SAMPLE_FILE_MST_IDX1
    ON SAMPLE_FILE_MST
        (
         FILE_SEQ,
         FILE_NAME
            );