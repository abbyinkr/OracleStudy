
--○ TBL_상품, TBL_입고, TBL_출고의 관계에서 
--   출고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--   TRG_CHULGO 트리거를 작성한다.
CREATE OR REPLACE TRIGGER TRG_CHULGO
    AFTER 
    INSERT OR UPDATE OR DELETE ON TBL_출고
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
                SET 재고수량 = 재고수량 - :NEW.출고수량
              WHERE 상품코드 = :NEW.상품코드;
            
    ELSIF (UPDATING)
        THEN UPDATE TBL_상품
                SET 재고수량 = 재고수량 + :OLD.출고수량 - :NEW.출고수량
              WHERE 상품코드 = :NEW.상품코드;

    ELSIF (DELETING)
        THEN UPDATE TBL_상품
                SET 재고수량 = 재고수량 + :OLD.출고수량
              WHERE 상품코드 = :OLD.상품코드;                                         
    END IF;

END;
--==>> Trigger TRG_CHULGO이(가) 컴파일되었습니다.