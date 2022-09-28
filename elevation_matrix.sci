function elevation_matrix(meshcode,elevation)
    //緯度、経度の計算
	gain_lat(3) = 30 / 3600;
	gain_lat(2) = gain_lat(3) * 10;
	gain_lat(1) = 1.5;

	gain_lng(3) = 45 / 3600;
	gain_lng(2) = gain_lng(3) * 10;
	gain_lng(1) = 100;//これは足すだけ

    disp(size(meshcode,'r'));
	for i = 1:size(meshcode,'r')
		mesh_lat(1) = strtod(part(meshcode(i),1:2));
		mesh_lng(1) = strtod(part(meshcode(i),3:4));
		mesh_lat(2) = strtod(part(meshcode(i),5));
		mesh_lng(2) = strtod(part(meshcode(i),6));
		mesh_lat(3) = strtod(part(meshcode(i),7));
		mesh_lng(3) = strtod(part(meshcode(i),8));

		lat(i) = mesh_lat(1) / gain_lat(1) + mesh_lat(2) * gain_lat(2) + mesh_lat(3) * gain_lat(3);
		lng(i) = mesh_lng(1) + gain_lng(1) + mesh_lng(2) * gain_lng(2) + mesh_lng(3) * gain_lng(3);
		
		y = mesh_lat(2) * 10 + mesh_lat(3) + 1;
		x = mesh_lng(2) * 10 + mesh_lng(3) + 1;
		
		T(x,y) = elevation(i);
		label_lat(y) = lat(i);
		label_lng(x) = lng(i);

	end

    //plot(lng,lat);
    //scf();
    grayplot(label_lng,label_lat,T);
    
    zm = min(elevation);
    zM = max(elevation);
    disp(zm);
    disp(zM);
    colorbar(zm,zM);
endfunction
