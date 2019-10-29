/* ȸ������ */

/* ������ 4�� ����� */


CREATE TABLE MemTable (
	MemNo NUMBER NOT NULL, /* ȸ����ȣ */
	Email VARCHAR2(30) NOT NULL, /* �̸��� */
	Pwd VARCHAR2(20) NOT NULL, /* ��й�ȣ */
	MemName VARCHAR2(10) NOT NULL, /* �̸� */
	Address VARCHAR2(80), /* �ּ� */
	Phone VARCHAR2(20), /* ��ȭ��ȣ */
	Mileage NUMBER DEFAULT 0 /* ���ϸ��� */
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

/* ��ǰ */
CREATE TABLE PdTable (
	PdNo NUMBER NOT NULL, /* ��ǰ��ȣ */
	PdName VARCHAR2(20) NOT NULL, /* ��ǰ�� */
	PdPrice NUMBER NOT NULL, /* ��ǰ���� */
	PdQty NUMBER NOT NULL, /* ��ǰ��� */
	PdDesc VARCHAR2(80), /* ��ǰ���� */
	PdImg VARCHAR2(100), /* ��ǰ�̹��� */
	PdMile NUMBER /* �������ϸ��� */
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

/* ��ٱ��� */
CREATE TABLE CartTable (
	OrderNo NUMBER NOT NULL, /* �ֹ��󼼹�ȣ */
	PdNo NUMBER NOT NULL, /* ��ǰ��ȣ */
	OrderQty NUMBER NOT NULL, /* ���� */
	MemNo NUMBER NOT NULL /* ȸ����ȣ */
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


/* �ֹ����� */
CREATE TABLE OrderedTable (
	No NUMBER NOT NULL, /* �ѹ� */
	OrderNo NUMBER NOT NULL, /* �ֹ��󼼹�ȣ */
	OrderDate DATE DEFAULT sysdate NOT NULL /* �ֹ����� */
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