
--○ TBL_출고 테이블에서 출고수량을 삭제하는 프로시저를 작성한다.
--   프로시저 명 : PRC_출고_DELETE(출고번호);

CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
(
    V_출고번호 IN TBL_출고.출고번호%TYPE
)
IS
    V_상품코드          TBL_상품.상품코드%TYPE;
    V_변경전출고수량    TBL_출고.출고수량%TYPE;
    V_변경전재고수량    TBL_상품.상품코드%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;

BEGIN

    -- 변수에 값 담기
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_변경전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    SELECT 재고수량 INTO V_변경전재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    
    --DELETE TBL_출고
    
    DELETE 
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    --UPDATE TBL_상품
    
    UPDATE TBL_상품  
    SET 재고수량 = V_변경전재고수량 + V_변경전출고수량
    WHERE 상품코드 = V_상품코드;
    
    --커밋
    COMMIT;
    


END;
--==>> Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.