public class Main {
    public static void main(String[] args) {
        // loop over the parameters, check if integers and check if prime numbers and print them
        for (String arg : args) {
            try {
                int num = Integer.parseInt(arg);
                if (isPrime(num)) {
                    System.out.println(num);
                }
            } catch (NumberFormatException e) {
                // ignore non-integer arguments
            }
        }
    }
    public static boolean isPrime(int num) {
        if (num < 2) {
            return false;
        }
        for (int i = 2; i <= Math.sqrt(num); i++) {
            if (num % i == 0) {
                return false;
            }
        }
        return true;
    }
}
