$fn = 1000;
module v(depth, angle, LScaleRatio, RScaleRatio)
{
	if (depth > 0)
	{
		union()
		{
			minkowski()
			{
				cube([100, 10, 10], center=true);
				rotate([0, 0, 45])
				cube([4, 4, 10], center=true);
				//cylinder(h=10, r=10);
			}
			translate([-50, 0 ,0])
			rotate([0, 0, angle])
			translate([50, 0, 0])
			union()
			{
				minkowski()
				{
					cube([100, 10, 10], center=true);
					//cylinder(h=10, r=10);
					rotate([0, 0, 45])
					cube([4, 4, 10], center=true);
				}
				translate([50, 0, 0])
				scale([LScaleRatio, LScaleRatio, 1])
				rotate([0, 0, -angle])
				translate([50, 0, 0])
				v(depth-1, angle, LScaleRatio, RScaleRatio);
				
			}
				translate([100, 0, 0])
				translate([-50, 0, 0])
				scale([LScaleRatio, RScaleRatio, 1])
				rotate([0, 0, 0])
				translate([50, 0, 0])
				v(depth-1, angle, LScaleRatio, RScaleRatio);
		}
	}	
}

module curvedV(depth, angle)
{
	intersection()
	{
		translate([0, 10, 45])
		rotate([0, 90, angle/2])
		cylinder(r=50, h=150, center=true);
		scale([0.5,0.5, 1])
		v(depth, angle, 0.5, 0.5);
	}
}

module repeatedV(depth, width, angle)
{
	offset = sqrt(100*100 + 100*100 - 2*100*100*cos(angle));
	for (i = [0:width])
	{
		translate([0, offset*i, 0])
		rotate([0, 0, -angle/2])
		v(depth, angle, 0.5, 0.5);
	}
}

//curvedV(4);
scale([1, 1, 0.3])
union()
{
scale([0.333, 0.333, 0.5])
	repeatedV(3, 2, 35);
	translate([-17, 25, 0])
	cube([1, 50, 10], center=true);
	translate([40, 25, 0])
	cube([1, 80, 10], center=true);
}

