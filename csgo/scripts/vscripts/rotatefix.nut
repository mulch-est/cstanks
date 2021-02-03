local FixAngRotation = function()
	{
    ent <- null;
    while((ent = Entities.FindByClassname(ent,"env_gunfire")) != null)
      {
        local angs = ent.GetAngles()

        if(angs.x > 360.0 || angs.y > 360.0 || angs.z > 360.0 || angs.x < -360.0 || angs.y < -360.0 || angs.z < -360.0)
          {
		        angs.x = floor(angs.x).tofloat() % 60);
		        angs.y = floor(angs.y).tofloat() % 60);
		        angs.z = floor(angs.z).tofloat() % 60);
			
		        ent.SetAngles(angs.x, angs.y, angs.z);
	        }
      }
  }
