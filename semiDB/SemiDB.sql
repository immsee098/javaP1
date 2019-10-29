/* 회원정보 */

/* 시퀀스 4개 만들기 */


CREATE TABLE MemTable (
	MemNo NUMBER NOT NULL, /* 회원번호 */
	Email VARCHAR2(30) NOT NULL, /* 이메일 */
	Pwd VARCHAR2(20) NOT NULL, /* 비밀번호 */
	MemName VARCHAR2(10) NOT NULL, /* 이름 */
	Address VARCHAR2(80), /* 주소 */
	Phone VARCHAR2(20), /* 전화번호 */
	Mileage NUMBER DEFAULT 0 /* 마일리지 */
);

CREATE UNIQUE INDEX MemberTable
	ON MemTable (
		MemNo ASC
	);

ALTER TABLE MemTable
	ADD
		CONSTRAINT MemberTable
		PRIMARY KEY (
			MemNo
		);

/* 상품 */
CREATE TABLE PdTable (
	PdNo NUMBER NOT NULL, /* 상품번호 */
	PdName VARCHAR2(20) NOT NULL, /* 상품명 */
	PdPrice NUMBER NOT NULL, /* 상품가격 */
	PdQty NUMBER NOT NULL, /* 상품재고 */
	PdDesc VARCHAR2(80), /* 상품내용 */
	PdImg VARCHAR2(100), /* 상품이미지 */
	PdMile NUMBER /* 적립마일리지 */
);

CREATE UNIQUE INDEX PdTable
	ON PdTable (
		PdNo ASC
	);

ALTER TABLE PdTable
	ADD
		CONSTRAINT PdTable
		PRIMARY KEY (
			PdNo
		);

/* 장바구니 */
CREATE TABLE CartTable (
	OrderNo NUMBER NOT NULL, /* 주문상세번호 */
	PdNo NUMBER NOT NULL, /* 상품번호 */
	OrderQty NUMBER NOT NULL, /* 수량 */
	MemNo NUMBER NOT NULL /* 회원번호 */
);

CREATE UNIQUE INDEX CartTable
	ON CartTable (
		OrderNo ASC
	);

ALTER TABLE CartTable
	ADD
		CONSTRAINT CartTable
		PRIMARY KEY (
			OrderNo
		);


/* 주문내역 */
CREATE TABLE OrderedTable (
	No NUMBER NOT NULL, /* 넘버 */
	OrderNo NUMBER NOT NULL, /* 주문상세번호 */
	OrderDate DATE DEFAULT sysdate NOT NULL /* 주문일자 */
);

CREATE UNIQUE INDEX OrderedTable
	ON OrderedTable (
		No ASC
	);

ALTER TABLE OrderedTable
	ADD
		CONSTRAINT OrderedTable
		PRIMARY KEY (
			No
		);

ALTER TABLE CartTable
	ADD
		CONSTRAINT FK_PdTable_TO_CartTable
		FOREIGN KEY (
			PdNo
		)
		REFERENCES PdTable (
			PdNo
		);

ALTER TABLE CartTable
	ADD
		CONSTRAINT FK_MemTable_TO_CartTable
		FOREIGN KEY (
			MemNo
		)
		REFERENCES MemTable (
			MemNo
		);

ALTER TABLE OrderedTable
	ADD
		CONSTRAINT FK_CartTable_TO_Ordered
		FOREIGN KEY (
			OrderNo
		)
		REFERENCES CartTable (
			OrderNo
		);