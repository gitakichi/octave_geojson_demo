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
gain_lat(3) = 30 / 3600;
gain_lat(2) = gain_lat(3) * 10;
gain_lat(1) = 1.5;

gain_lng(3) = 45 / 3600;
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
	
	lat(i) = mesh_lat(1) / gain_lat(1) + mesh_lat(2) * gain_lat(2) + mesh_lat(3) * gain_lat(3);
	lng(i) = mesh_lng(1) + gain_lng(1) + mesh_lng(2) * gain_lng(2) + mesh_lng(3) * gain_lng(3);
	
	y = (mesh_lat(1)-54) * 80 + mesh_lat(2) * 10 + mesh_lat(3) + 1;//ここに1次メッシュコードを足す
	x = (mesh_lng(1)-39) * 80 + mesh_lng(2) * 10 + mesh_lng(3) + 1;//ここに1次メッシュコードを足す
	
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

//GMLの並び
//5539 5540
//5439 5440

