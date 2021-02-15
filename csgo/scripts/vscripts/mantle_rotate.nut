thinkTimer <- null;

function OnPostSpawn()
{
	//Creates the timer and sets it up to run the function Think in this script.
	if(thinkTimer == null)
	{
		thinkTimer = Entities.CreateByClassname("logic_timer");			//create timer
		thinkTimer.ValidateScriptScope(); 								//ensure it's scope is created 
		local timerScope = thinkTimer.GetScriptScope(); 				//get the scope											
									
		timerScope.mainScriptScope <- self.GetScriptScope();			//save the scope of this script to a variable in timer's scope
		timerScope.DoThink <- function() { mainScriptScope.Think() };	//create a DoThink function in the timer's scope to call the Think in this script
		
		thinkTimer.ConnectOutput("OnTimer", "DoThink"); 				//Run DoThink on every timer tick
		
		thinkTimer.__KeyValueFromFloat("RefireTime", 0.1); 				//set the frequency of the timer. You get RefireTime when disabling smartedit in hammer.
		EntFireByHandle(thinkTimer, "Enable", "", 0, null, null); 		//finally, start the timer
	}
}

//Think function the timer will run
function Think()
	{
		local ang = self.GetAngles();
		if(ang.x > 15){
			self.SetAngles(15, 0, 0);
			DoEntFire( "!self", "Stop", "", 0, self, self );
		}else if(ang.x < -22){
			self.SetAngles(-22, 0, 0);
			DoEntFire( "!self", "Stop", "", 0, self, self );
		}
	}
function StartForward()
	{
		printl("called StartForward");
		
		local mantleAngles = self.GetAngles();
		
		printl(mantleAngles.x+","+mantleAngles.y+","+mantleAngles.z);
		
		if(mantleAngles.x < 15){
			DoEntFire( "!self", "StartForward", "", 0, self, self );
		}
	}
	
function StartBackward()
	{
		printl("called StartBackward");

		local mantleAngles = self.GetAngles();
		
		printl(mantleAngles.x+","+mantleAngles.y+","+mantleAngles.z);
		
		if(mantleAngles.x > -22){
			DoEntFire( "!self", "StartBackward", "", 0, self, self );
		}
	}