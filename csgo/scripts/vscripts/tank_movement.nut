	//EntityGroup[] contains 4 phys_thrusters: LF, LB, RF, RB, EX
	lf_thruster <- EntityGroup[0];
	lb_thruster <- EntityGroup[1];
	rf_thruster <- EntityGroup[2];
	rb_thruster <- EntityGroup[3];
	ex_thruster <- EntityGroup[4]; //extra thruster, allows turns in one place by applying bare minimum forward force
	
	//_list contains four keyDown values: W,A,S,D
	local _list=[0, 0, 0, 0];
	
	function ChangeMovement() : (_list, lf_thruster, lb_thruster, rf_thruster, rb_thruster, ex_thruster)
	{
		const exForce=200;//force during stationary turn
		const normalForce=500;//force during straightline
		const weakForce=300;//force of one track during fast turn
		
		DoEntFire( lf_thruster.GetName(), "AddOutput", "Force "+normalForce, 0, self, self );
		DoEntFire( lb_thruster.GetName(), "AddOutput", "Force "+normalForce, 0, self, self );
		DoEntFire( rf_thruster.GetName(), "AddOutput", "Force "+normalForce, 0, self, self );
		DoEntFire( rb_thruster.GetName(), "AddOutput", "Force "+normalForce, 0, self, self );
		
		DoEntFire( ex_thruster.GetName(), "Activate", "", 0, self, self );
		
		if(_list[0]==1)//upDown
		{
			DoEntFire( lf_thruster.GetName(), "Activate", "", 0, self, self );
			DoEntFire( lb_thruster.GetName(), "Deactivate", "", 0, self, self );
			DoEntFire( rf_thruster.GetName(), "Activate", "", 0, self, self );
			DoEntFire( rb_thruster.GetName(), "Deactivate", "", 0, self, self );
			
			if(_list[1]==1)//leftDown
			{
				//UpLeft();
				DoEntFire( lf_thruster.GetName(), "AddOutput", "Force "+weakForce, 0, self, self );
			}else if(_list[3]==1)//rightDown
			{
				//UpRight();
				DoEntFire( rf_thruster.GetName(), "AddOutput", "Force "+weakForce, 0, self, self );
			}
		} else if(_list[2]==1)//downDown
		{
			DoEntFire( lf_thruster.GetName(), "Deactivate", "", 0, self, self );
			DoEntFire( lb_thruster.GetName(), "Activate", "", 0, self, self );
			DoEntFire( rf_thruster.GetName(), "Deactivate", "", 0, self, self );
			DoEntFire( rb_thruster.GetName(), "Activate", "", 0, self, self );
				
			if(_list[1]==1)//leftDown
			{
				//DownLeft();
				DoEntFire( lb_thruster.GetName(), "AddOutput", "Force "+weakForce, 0, self, self );
			}else if(_list[3]==1)//rightDown
			{
				//DownRight();
				DoEntFire( rb_thruster.GetName(), "AddOutput", "Force "+weakForce, 0, self, self );
			}
		} else
		{
			if(_list[1]==1)//leftDown
			{
				//StatLeft();
				
				DoEntFire( lb_thruster.GetName(), "AddOutput", "Force "+exForce, 0, self, self );
				DoEntFire( rf_thruster.GetName(), "AddOutput", "Force "+exForce, 0, self, self );
				
				DoEntFire( lf_thruster.GetName(), "Deactivate", "", 0, self, self );
				DoEntFire( lb_thruster.GetName(), "Activate", "", 0, self, self );
				DoEntFire( rf_thruster.GetName(), "Activate", "", 0, self, self );
				DoEntFire( rb_thruster.GetName(), "Deactivate", "", 0, self, self );
			}else if(_list[3]==1)//rightDown
			{
				//StatRight();
				DoEntFire( lf_thruster.GetName(), "AddOutput", "Force "+exForce, 0, self, self );
				DoEntFire( rb_thruster.GetName(), "AddOutput", "Force "+exForce, 0, self, self );
				
				DoEntFire( lf_thruster.GetName(), "Activate", "", 0, self, self );
				DoEntFire( lb_thruster.GetName(), "Deactivate", "", 0, self, self );
				DoEntFire( rf_thruster.GetName(), "Deactivate", "", 0, self, self );
				DoEntFire( rb_thruster.GetName(), "Activate", "", 0, self, self );
			}else
			{
				//Stop();
				DoEntFire( lf_thruster.GetName(), "Deactivate", "", 0, self, self );
				DoEntFire( lb_thruster.GetName(), "Deactivate", "", 0, self, self );
				DoEntFire( rf_thruster.GetName(), "Deactivate", "", 0, self, self );
				DoEntFire( rb_thruster.GetName(), "Deactivate", "", 0, self, self );
				DoEntFire( ex_thruster.GetName(), "Deactivate", "", 0, self, self );
			}
		}
		
		return null;
	}
	
	//local ChangeMovement = ChangeMovement;
	
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
		_list.remove(0);
		_list.insert(0, 1);
		ChangeMovement();
	}
	
	function PressedBack() : (_list, ChangeMovement)
	{
		_list.remove(2);
		_list.insert(2, 1);
		ChangeMovement();
	}
	
	function PressedMoveLeft() : (_list, ChangeMovement)
	{
		_list.remove(1);
		_list.insert(1, 1);
		ChangeMovement();
	}
	
	function PressedMoveRight() : (_list, ChangeMovement)
	{
		_list.remove(3);
		_list.insert(3, 1);
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