public class Gcd {
    public static void main(String[] args) {
        // print the greatest common divisors of all the numbers in the command line arguments
        try {
            Integer gcd = Integer.parseInt(args[0]);
            for (int i = 1; i < args.length; i++) {
                gcd = gcd(gcd, Integer.parseInt(args[i]));
            }
            System.out.println(gcd);
        } catch (NumberFormatException e) {
            // ignore the non number
        }
    }
    // greatest common divisor
    public static int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}
