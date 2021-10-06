Class FCE.Ship Extends %Persistent
{

Property positionX As %Integer;

Property positionY As %Integer;

Property degrees As %Integer;

Property waypointX As %Integer;

Property waypointY As %Integer;

ClassMethod Preparation() As %Status
{
                
    // We will set up a lines array and add the values within it
    set lines =##class(%ArrayOfDataTypes).%New()
    do lines.SetAt("F10","1")
    do lines.SetAt("N3","2")
    do lines.SetAt("F7","3")
    do lines.SetAt("R90","4")
    do lines.SetAt("F11","5")

    // Next we set up a loop to count through the lines and we will extract the directions and values
    // from the array. We will create two globals that are to be accessed using the count variable.
 
    set lim = ""
    set count = 1
    for i=1:1:lines.Count() 
    {
        //write lines.GetAt(i),!
        set direction(count)=$EXTRACT(lines.GetAt(i),1,1)
        write direction(count),!
        
        set value(count)=$EXTRACT(lines.GetAt(i),2,3)
        //write value(count) ,!
        set count =$INCREMENT(count) 
    }
                
                
    // And finally we will pass the new variables value and direction to the first part of the exercise.           
    //do ..Firstpart(.value,.direction)
    do ..Secondpart(.value, .direction)
}

ClassMethod Firstpart(ByRef value As %ArrayOfDataTypes, ByRef direction As %ArrayOfDataTypes) As %Status
{

    // Create new instance and set up properties on the instance to initialise the variables
    set ship=##class(FCE.Ship).%New()
    set ship.degrees = 90
    set ship.positionX = 0
    set ship.positionY = 0
    
    
    // set the counter and the compass direction variables
    set count=1
    
    set compass(N) = 0
    set compass(E) = 90
    set compass(S) = 180
    set compass(S) = 270
                

    // set up a for loop to loop through the directions and set the ships position and degrees          
    for i=1:1:5
    {
        write "Count is: ", count ,!
        //write "Direction: ",direction(count) ,!
        if direction(count) = "N" 
        {
            write "Set North position " ,!
            set ship.positionY = ship.positionY + value(count)
            write "Ships position: ", ship.positionY ,!
        } elseif direction(count) = "E"{
            write "Set East position " ,!
            set ship.positionX = ship.positionX + value(count)
            write "Ships position: ", ship.positionX ,!
                                        
        } elseif direction(count)= "S" {
            write "Set South position " ,!
            set ship.positionY = ship.positionY - value(count)
            write "Ships position: ", ship.positionY ,!
        
        } elseif direction(count)= "W" {
            write "Set West position " ,!
            set ship.positionX = ship.positionX - value(count)
            write "Ships position: ", ship.positionX ,!
        } elseif direction(count)= "F" {
            write "We are moving forward " ,!
            if compass(E) = ship.degrees {
                set ship.positionX = ship.positionX + value(count)
                set ship.positionY = ship.positionY + value(count)
                            
            }
                        
        } elseif direction(count) = "L" {
            write "Turn to the left " ,!
            set ship.degrees = ship.degrees - value(count)
            if (ship.degrees < 0) {
                            set ship.degrees = ship.degrees + 360
            }
        } elseif direction(count) = "R" {
            write "We are reversing " ,!
            set ship.degrees = ship.degrees + value(count)
        }              
        if (ship.degrees >= 360) {
            set ship.degrees = ship.degrees - 360
        } 
            set count =$INCREMENT(count) 
    }
}

ClassMethod Secondpart(ByRef value As %ArrayOfDataTypes, ByRef direction As %ArrayOfDataTypes)
{
    // Create new instance and set up properties on the instance to initialise the variables            
    set ship=##class(FCE.Ship).%New()
    set ship.degrees = 90
    set ship.positionX = 0
    set ship.positionY = 0
    set ship.waypointX = 10
    set ship.waypointY = 1
    set count=1

    // Set up a for loop to go through the directions and set various waypoints on an X and Y axis.
    // Each waypoint is written out to the screen
    
    for i=1:1:5
    {
       
        if direction(count) = "N" 
        {
            write "Go North" ,!
            set ship.waypointY = ship.waypointY + value(count)
            write "North's waypointY: ", ship.waypointY ,!
        } elseif direction(count) = "E"{
            write "Go East " ,!
            set ship.waypointX = ship.waypointX + value(count)
            write "East's waypointX: ", ship.waypointX ,!
                                        
        } elseif direction(count)= "S" {
            write "Go South" ,!
            set ship.waypointY = ship.waypointY - value(count)
            write "South's waypointY: ", ship.waypointY ,!
        
        } elseif direction(count)= "W" {
            write "Go West" ,!
            set ship.waypointX = ship.waypointX - value(count)
            write "West's waypointX: ", ship.waypointX ,!
        } elseif direction(count)= "F" {
            write "Move Forward " ,!
            set ship.positionX = ship.waypointX * value(count)
            set ship.positionY = ship.waypointY * value(count)
            write "Forward waypointX: ", ship.waypointX ,!
            write "Forward waypointY: ", ship.waypointY ,!            
        } elseif direction(count) = "L" {
            write "Turn Left " ,!
            if value(count) = 90 {
                set ship.waypointX = $REVERSE(ship.waypointX)
                set ship.waypointX = ship.waypointX * -1
                write "Left's 90 degree waypointX is :",ship.waypointX ,!
            } elseif value(count) = 180 {
                set ship.waypointX = ship.waypointX * -1
                set ship.waypointY = ship.waypointY * -1
                write "Left's 180 degree waypointY is :",ship.waypointY ,!
            } elseif value(count) = 270 {
                set ship.waypointY = $REVERSE(ship.waypointY)
                set ship.waypointY = ship.waypointY * -1
                write "Left's 270 degree waypointY is :",ship.waypointY ,!
            } else {

            }

        } elseif direction(count) = "R" {
            write "Reverse ! " ,!
             
            if value(count) = 90 {
                set ship.waypointY = $REVERSE(ship.waypointY)
                set ship.waypointY = ship.waypointY * -1
                write "Reverse waypointY is :",ship.waypointY ,!
            } elseif value(count) = 180 {
                set ship.waypointX = ship.waypointX * -1
                set ship.waypointY = ship.waypointY * -1
                write "Reverse waypointY is :",ship.waypointY ,!
            } elseif value(count) = 270 {
                set ship.waypointX = $REVERSE(ship.waypointX)
                set ship.waypointX = ship.waypointX * -1
                write "Reverse waypointX is :",ship.waypointX ,!
            } else {

            }
        }              
        
        set count =$INCREMENT(count) 
    }
}

Storage Default
{
<Data name="ShipDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>positionX</Value>
</Value>
<Value name="3">
<Value>positionY</Value>
</Value>
<Value name="4">
<Value>degrees</Value>
</Value>
<Value name="5">
<Value>waypointX</Value>
</Value>
<Value name="6">
<Value>waypointY</Value>
</Value>
</Data>
<DataLocation>^FCE.ShipD</DataLocation>
<DefaultData>ShipDefaultData</DefaultData>
<IdLocation>^FCE.ShipD</IdLocation>
<IndexLocation>^FCE.ShipI</IndexLocation>
<StreamLocation>^FCE.ShipS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
