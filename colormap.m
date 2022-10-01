//GMLからデータを取り出す
[meshcode1,elevation1] = get_elevation('G04-d-11_5439-jgd.xml');
[meshcode2,elevation2] = get_elevation('G04-d-11_5440-jgd.xml');
[meshcode3,elevation3] = get_elevation('G04-d-11_5539-jgd.xml');
[meshcode4,elevation4] = get_elevation('G04-d-11_5540-jgd.xml');

//GMLから取り出したデータをマージする
meshcode = [meshcode1;meshcode2;meshcode3;meshcode4];
elevation = [elevation1;elevation2;elevation3;elevation4];

//マージしたデータを表示する
//elevation_matrix(meshcode,elevation);

//緯度、経度の計算
gain_lat(5) = 7.5 / 3600;
gain_lat(4) = gain_lat(5) * 2;
gain_lat(3) = gain_lat(4) * 2;
gain_lat(2) = gain_lat(3) * 10;
gain_lat(1) = 1.5;

gain_lng(5) = 11.25 / 3600;
gain_lng(4) = gain_lng(5) * 2;
gain_lng(3) = gain_lng(4) * 2;
gain_lng(2) = gain_lng(3) * 10;
gain_lng(1) = 100;//これは足すだけ

//disp(size(meshcode,'r'));
for i = 1:size(meshcode,'r')
	mesh_lat(1) = strtod(part(meshcode(i),1:2));
	mesh_lng(1) = strtod(part(meshcode(i),3:4));
	mesh_lat(2) = strtod(part(meshcode(i),5));
	mesh_lng(2) = strtod(part(meshcode(i),6));
	mesh_lat(3) = strtod(part(meshcode(i),7));
	mesh_lng(3) = strtod(part(meshcode(i),8));
	
	
	//partは文字列を部分的に取得する関数
	
	if part(meshcode(i),9) == '4' then
		mesh_lat(4) = 1;
		mesh_lng(4) = 1;
	elseif part(meshcode(i),9) == '3' then
		mesh_lat(4) = 1;
		mesh_lng(4) = 0;
	elseif part(meshcode(i),9) == '2' then
		mesh_lat(4) = 0;
		mesh_lng(4) = 1;
	elseif part(meshcode(i),9) == '1' then
		mesh_lat(4) = 0;
		mesh_lng(4) = 0;
	end
	
	if part(meshcode(i),10) == '4' then
		mesh_lat(5) = 1;
		mesh_lng(5) = 1;
	elseif part(meshcode(i),10) == '3' then
		mesh_lat(5) = 1;
		mesh_lng(5) = 0;
	elseif part(meshcode(i),10) == '2' then
		mesh_lat(5) = 0;
		mesh_lng(5) = 1;
	elseif part(meshcode(i),10) == '1' then
		mesh_lat(5) = 0;
		mesh_lng(5) = 0;
	end
	
	
	lat(i) = mesh_lat(1) / gain_lat(1) + mesh_lat(2) * gain_lat(2) + mesh_lat(3) * gain_lat(3) + mesh_lat(4) * gain_lat(4) + mesh_lat(5) * gain_lat(5);
	lng(i) = mesh_lng(1) + gain_lng(1) + mesh_lng(2) * gain_lng(2) + mesh_lng(3) * gain_lng(3) + mesh_lng(4) * gain_lng(4) + mesh_lng(5) * gain_lng(5);
	
	y = (mesh_lat(1)-54) * 320 + mesh_lat(2) * 40 + mesh_lat(3) * 4 + mesh_lat(4) * 2 + mesh_lat(5) + 1;
	x = (mesh_lng(1)-39) * 320 + mesh_lng(2) * 40 + mesh_lng(3) * 4 + mesh_lng(4) * 2 + mesh_lng(5) + 1;
	
	T(x,y) = elevation(i);
	label_lat(y) = lat(i);
	label_lng(x) = lng(i);

end

//plot(lng,lat);
//scf();
grayplot(label_lng,label_lat,T);

zm = min(elevation);
zM = max(elevation);
//disp(zm);
//disp(zM);
colorbar(zm,zM);

//GMLの並び
//5539 5540
//5439 5440

