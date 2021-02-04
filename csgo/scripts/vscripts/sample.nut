function FixAngRotation()
	{
		printl("called FixAngRotation()");
		
		ent <- null;
		while((ent = Entities.FindByClassname(ent,"info_target")) != null)
			{
				printl(ent.GetName()+" is being checked");
				local vector = ent.GetAngles();
				printl(vector.x+","+vector.y+","+vector.z);
				if(ent.GetName() == "static_target")
				{
					DoEntFire( ent.GetName(), "SetLocalAngles", "0, 0, 0", 0, self, self )
					//ent.SetLocalAngles(0, 0, 0);
					printl("reset static_target angles");
				}
				/*local angs = ent.GetLocalAngles()
				printl("before:"+angs.x+","+angs.y+","+angs.z);
				
				if(angs.x > 360.0 || angs.y > 360.0 || angs.z > 360.0 || angs.x < -360.0 || angs.y < -360.0 || angs.z < -360.0)
					{
						angs.x = floor(angs.x).tofloat()%60;
						angs.y = floor(angs.y).tofloat()%60;
						angs.z = floor(angs.z).tofloat()%60;
			
						ent.SetLocalAngles(angs.x, angs.y, angs.z);
					}
					
				printl("after:"+angs.x+","+angs.y+","+angs.z);*/
			}
	}