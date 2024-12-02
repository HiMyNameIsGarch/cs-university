public class Double {
    public static void main(String[] args) {
        for(int i = 0; i < args.length - 1; i+=2) {
            try {
                if (Integer.parseInt(args[i]) > Integer.parseInt(args[i+1])) {
                    System.out.println(args[i]);
                } else {
                    System.out.println(args[i+1]);
                }
            } catch (NumberFormatException e) {
                // ignore the non number
            }
        }
    }
}
