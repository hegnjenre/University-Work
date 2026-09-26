public class AirCon
{
    private int temp = 0;
    private boolean OF = false;

    public AirCon()
    {
        temp = 20;
        OF = true;
    }

    public int getTemp()
    {
        return temp; 
    }
    
    public void increaseTempBy2()
    {
        temp += 2;
    }
    
    public void decreaseTempBy2()
    {
        temp -= 2;
    }
    
    public void increaseTemp(int inc)
    {
        temp += inc;
    }
    
    public void printTemp()
    {
        System.out.println("Desired Temperature: " + temp);
        if(OF == true){
            System.out.println("Air Conditioner is On");
        }
        else if(OF == false){
            System.out.println("Air Conditioner is Off");
        }
    }
    
    public void switchOn()
    {
        OF = true;
    }
    
    public void switchOff()
    {
        OF = false;
    }
    
}
