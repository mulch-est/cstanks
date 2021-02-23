	//EntityGroup[] 0-3 contain UDLR thrusters
	//EntityGroup[] 4-5 contain track breakables
	
	up_thruster <- EntityGroup[0];
	down_thruster <- EntityGroup[1];//left
	left_thruster <- EntityGroup[2];//down
	right_thruster <- EntityGroup[3];
	
	left_track <- EntityGroup[4].GetName()+"*";
	right_track <- EntityGroup[5].GetName()+"*";
	//left and right track wildcards are created by point_teslas with similar names
	//they must be killed off here to allow for proper immobilization checks
	DoEntFire( EntityGroup[4].GetName(), "Kill", "", 0, self, self );
	DoEntFire( EntityGroup[5].GetName(), "Kill", "", 0, self, self );
	
	//_list contains four keyDown values: W,A,S,D
	local _list=[0, 0, 0, 0];
	
	function ApplyMovement() : (_list, up_thruster, down_thruster, left_thruster, right_thruster)
	{
		print("ApplyMovement() ");
		if(_list[0]==1)print("W");
		if(_list[1]==1)print("A");
		if(_list[2]==1)print("S");
		if(_list[3]==1)print("D");
		print("\n");
		
		if(_list[0]==0 && _list[2]==0)
		{
			//printl("no linear movement (only torque)");
			
			//deactivate thrusters on stop here, or trigger rotate.
			
			if(_list[1]==1)//left
			{
				//DoEntFire( upr_thruster.GetName(), "TurnOn", "", 0, self, self );
			}else if(_list[3]==1)//right
			{
				//DoEntFire( downr_thruster.GetName(), "TurnOn", "", 0, self, self );
			}else //stop
			{
				DoEntFire( up_thruster.GetName(), "Deactivate", "", 0, self, self );
				DoEntFire( down_thruster.GetName(), "Deactivate", "", 0, self, self );
				DoEntFire( left_thruster.GetName(), "Deactivate", "", 0, self, self );
				DoEntFire( right_thruster.GetName(), "Deactivate", "", 0, self, self );
				//DoEntFire( upr_thruster.GetName(), "TurnOff", "", 0, self, self );
				//DoEntFire( downr_thruster.GetName(), "TurnOff", "", 0, self, self );
			}
		}else
		{
			//printl("normal activate/deactivate depending on keys down");
			
			//DoEntFire( upr_thruster.GetName(), "TurnOff", "", 0, self, self );
			//DoEntFire( downr_thruster.GetName(), "TurnOff", "", 0, self, self );
			
			if(_list[0]==1)
			{
				DoEntFire( up_thruster.GetName(), "Activate", "", 0, self, self );
			}else
			{
				DoEntFire( up_thruster.GetName(), "Deactivate", "", 0, self, self );
			}
			
			if(_list[3]==1)//some kind of errors in the script, now they are switched and the names make no sense
			{
				DoEntFire( left_thruster.GetName(), "Activate", "", 0, self, self );
			}else
			{
				DoEntFire( left_thruster.GetName(), "Deactivate", "", 0, self, self );
			}
			
			if(_list[2]==1)
			{
				DoEntFire( down_thruster.GetName(), "Activate", "", 0, self, self );
			}else
			{
				DoEntFire( down_thruster.GetName(), "Deactivate", "", 0, self, self );
			}
			
			if(_list[1]==1)
			{
				DoEntFire( right_thruster.GetName(), "Activate", "", 0, self, self );
			}else
			{
				DoEntFire( right_thruster.GetName(), "Deactivate", "", 0, self, self );
			}
		}
	}
	
	function ChangeMovement() : (left_track, right_track, ApplyMovement)
	{
		printl("ChangeMovement()");
		printl(left_track);
		printl(right_track);
		lt <- Entities.FindByName( null, left_track );
		rt <- Entities.FindByName( null, right_track );
		
		if(lt!=null && rt!=null)ApplyMovement();
	}
	
	function Stop() : (_list, ChangeMovement)
	{
		for(local i=0; i<4; i++)
		{
			_list.remove(i);
			_list.insert(i, 0);
		}
		
		ChangeMovement();
	}
	
	function PressedForward() : (_list, ChangeMovement)
	{
		printl("PressedForward()");
		
		_list.remove(0);
		_list.insert(0, 1);
		
		_list.remove(2);
		_list.insert(2, 0);//turn off backwards press
		
		ChangeMovement();
	}
	
	function PressedBack() : (_list, ChangeMovement)
	{
		_list.remove(2);
		_list.insert(2, 1);
		
		_list.remove(0);
		_list.insert(0, 0);//turn off forwards press
		
		ChangeMovement();
	}
	
	function PressedMoveLeft() : (_list, ChangeMovement)
	{
		printl("PressedMoveLeft()");
		
		_list.remove(1);
		_list.insert(1, 1);
		
		_list.remove(3);
		_list.insert(3, 0);//turn off right press
		
		ChangeMovement();
	}
	
	function PressedMoveRight() : (_list, ChangeMovement)
	{
		_list.remove(3);
		_list.insert(3, 1);
		
		_list.remove(1);
		_list.insert(1, 0);//turn off left press
		
		ChangeMovement();
	}
	
	function UnpressedForward() : (_list, ChangeMovement)
	{
		_list.remove(0);
		_list.insert(0, 0);
		ChangeMovement();
	}
	
	function UnpressedBack() : (_list, ChangeMovement)
	{
		_list.remove(2);
		_list.insert(2, 0);
		ChangeMovement();
	}
	
	function UnpressedMoveLeft() : (_list, ChangeMovement)
	{
		_list.remove(1);
		_list.insert(1, 0);
		ChangeMovement();
	}
	
	function UnpressedMoveRight() : (_list, ChangeMovement)
	{
		_list.remove(3);
		_list.insert(3, 0);
		ChangeMovement();
	}