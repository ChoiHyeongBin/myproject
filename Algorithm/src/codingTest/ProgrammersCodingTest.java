package codingTest;


public class ProgrammersCodingTest {

	public static void main(String[] args) {
		int a = 3;
		int b = 2;
		int n = 20;
		
		solution(a, b, n);
	}

	static int answer = 0;
	public static int solution(int a, int b, int n) {
        for (int i = n; i > 0; i--) {
        	if (i % a == 0) {
        		System.out.println("i : " + i);
        		n = n - i + (i / a) * b;
        		System.out.println("n : " + n);
        		System.out.println("a : " + a);
        		System.out.println("받은것 : " + (i / a) * b);
        		answer += (i / a) * b;
        		System.out.println("answer11 : " + answer);
        		System.out.println();
        		
        		// 남아있는 개수가 콜라를 받기 위해 마트에 주어야 하는 병 수보다 적으면 멈춤
        		if (n < a) {
        			System.out.println("if문 탔음");
        			System.out.println("최종 answer : " + answer);
        			return answer;
        		} else {
        			System.out.println("else문 탔음");
        			solution(a, b, n);
        		}
        		
        		break;
        	}
        }
        
        System.out.println("answer222 : " + answer);
        return answer;
    }
	
}
