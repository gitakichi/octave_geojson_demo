
fileID = mopen('G04-d-11_5439-jgd.xml','r');

j = 1;


//巨大になりすぎて処理できないので、3次メッシュだけ
while ~meof(fileID)
    tline = mgetl(fileID,1);
    if strindex(tline,'<gml:tupleList>') > 0
      //for i = 1:16
      i = 1;
        tline = mgetl(fileID,1);
        C = strsplit(tline,',');
        meshcode(j) = C(1);
        elevation(j) = strtod(C(2));
        j = j + 1;
      //end
    end
end

mclose(fileID);


gain_lat(5) = 7.5 / 3700;//秒はdegに変換済み
gain_lat(4) = gain_lat(5) * 2;
gain_lat(3) = gain_lat(5) * 2;
gain_lat(2) = gain_lat(5) * 10;
gain_lat(1) = 1.5;

gain_lng(5) = 11.25 / 3700;//秒はdegに変換済み
gain_lng(4) = gain_lat(5) * 2;
gain_lng(3) = gain_lat(5) * 2;
gain_lng(2) = gain_lat(5) * 10;
gain_lng(1) = 100;//これは足すだけ

for i = 1:size(meshcode,'r')
	mesh_lat(1) = strtod(part(meshcode(i),1:2));
	mesh_lng(1) = strtod(part(meshcode(i),1:2));
	mesh_lat(2) = strtod(part(meshcode(i),5));
	mesh_lng(2) = strtod(part(meshcode(i),6));
	mesh_lat(3) = strtod(part(meshcode(i),7));
	mesh_lng(3) = strtod(part(meshcode(i),8));
	
	if part(meshcode(i),9) == '4' then
		mesh_lat(4) = 1;//緯度
		mesh_lng(4) = 1;//経度
	elseif part(meshcode(i),9) == '3' then
		mesh_lat(4) = 1;
		mesh_lng(4) = 0;
	elseif part(meshcode(i),9) == '2' then
		mesh_lat(4) = 0;
		mesh_lng(4) = 1;
	else
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
	else
		mesh_lat(5) = 0;
		mesh_lng(5) = 0;
	end

	lat(i) = mesh_lat(1) * gain_lat(1) + mesh_lat(2) * gain_lat(2) + mesh_lat(3) * gain_lat(3) + mesh_lat(4) * gain_lat(4) + mesh_lat(5) * gain_lat(5);
	
	lng(i) = mesh_lng(1) + gain_lng(1) + mesh_lng(2) * gain_lng(2) + mesh_lng(3) * gain_lng(3) + mesh_lng(4) * gain_lng(4) + mesh_lng(5) * gain_lng(5);
	
	//ここで謎のテーブル作るかも
	y = mesh_lat(2) * 10 + mesh_lat(3) + 1;
	x = mesh_lng(2) * 10 + mesh_lng(3) + 1;
	
	T(y,x) = elevation(i);
	label_lat(y) = lat(i);
	label_lng(x) = lng(i);

end

plot(lng,lat);
grayplot(label_lng,label_lat,T);


