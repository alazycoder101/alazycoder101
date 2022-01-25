public class Main
{
    public static void main(String[] args) {
        boolean x, y, z;
        x = y = z = true;
        if (!x || (!y && !z))
           System.out.println("Hi");
        else
           System.out.println("Hello");
    }

}
