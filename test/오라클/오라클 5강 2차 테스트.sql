--[ 오라클 5강 2차 ]

--(1) 학과별 교수의 인원수와 백분율 구하기- professor 테이블 이용


--(2) employees에서 사원정보와 직속상관의 이름 구하기
--스칼라서브쿼리 이용
--직속상관의 경우 직속상관이 없으면 사장이라고 출력


--(3) employees에서 salary로 내림차순 정렬해서 상위 6건만 조회


--(4) 위 3번 문제에서 상위에서 2~4 사이인 데이터 조회하기


--(5) 학과별, 성별 평균키 구하기 - student 테이블
--inline view 이용


--(6) 각 부서에 속하는 사원정보(부서번호, 사원번호, 사원이름, 직급, 급여)를 조회하고, 
--부서별 평균급여도 출력하시오 -emp2
--inline view 이용


--(7)  김재수와  학과(deptno1)가 같은 학생들의 학번(studno), 이름(name), 학년(grade), 학과번호(deptno1)를 조회하되 이름(name)의 내림차순으로 조회
--서브 쿼리 이용 


--(8) 급여(pay)가 교수 전체의 평균급여보다 큰 교수의 이름(name), 직급(position), 급여(pay), 입사일(hiredate)의 데이터 가져오기.
--서브 쿼리 이용


--(9) emp2 테이블과 dept2 테이블을 참조하여 근무지역 
--(dept2 테이블의 area 칼럼)이 포항본사인 모든 사원들의 사번과 이름, 부서번호를 출력하시오


--(10) employees 테이블을 조회하여 직원들 중에서 자신의 부서의 평균 급여보다 적게 받는 사람들의 이름, 부서번호, 
--현재급여를 출력하시오.


--(11) professor 테이블과 department 테이블을 조회하여 교수들의 정보와 학과이름을 조회
--스칼라 서브쿼리 이용 


--(12) 각 부서에 해당하는 사원수 구하기
--departments, employees 이용


--(13) exam_01 테이블에서 점수가 높은 순으로 6명 조회하기


--(14) Student, exam_01 테이블에서  총점이 90이상인 학생들의 정보 조회
--exists 이용


--in 이용
