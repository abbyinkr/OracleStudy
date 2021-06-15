
--○ TBL_입고 테이블에서 입고수량을 수정(변경)하는 프로시저를 작성한다.
--   프로시저 명 : PRC_입고_UPDATE(입고번호, 변경할입고수량);
CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
(
    V_입고번호  IN TBL_입고.입고번호%TYPE
  , V_입고수량  IN TBL_입고.입고수량%TYPE
)
IS 
    V_상품코드          TBL_상품.상품코드%TYPE;
    V_변경전입고수량    TBL_입고.입고수량%TYPE;
    V_변경전재고수량    TBL_상품.상품코드%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;

BEGIN
    SELECT 상품코드, 입고수량 INTO V_상품코드, V_변경전입고수량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    SELECT 재고수량 INTO V_변경전재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    
    -- 예외 발생  
    -- V_이전재고수량 + V_입고수량 - V_이전입고수량 < 0
    IF( (V_변경전재고수량+V_입고수량) < V_변경전입고수량 )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --UPDATE (TBL_입고, 입고수량)
    UPDATE TBL_입고
       SET 입고수량 = V_입고수량 
     WHERE 입고번호 = V_입고번호;
    
    --UPDATE (TBL_상품, 재고수량)
    UPDATE TBL_상품
      SET 재고수량 = V_변경전재고수량 + V_입고수량 - V_변경전입고수량
     WHERE 상품코드 = V_상품코드;

    -- 커밋
    COMMIT;
    
    --발생한 예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!');
             ROLLBACK;
        WHEN OTHERS
        THEN ROLLBACK;

END;
--==>> Procedure PRC_입고_UPDATE이(가) 컴파일되었습니다.